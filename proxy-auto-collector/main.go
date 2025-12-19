package main

import (
	"fmt"
	"net"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
	"strings"
	"sync"
	"time"
)

type Proxy struct {
	Addr    string
	Latency time.Duration
}

const (
	timeout = 3 * time.Second
	workers = 500
)

func main() {
	os.MkdirAll("proxyresult", 0755)

	proxies := loadProxies()
	fmt.Println("Loaded proxies:", len(proxies))

	if len(proxies) == 0 {
		fmt.Println("❌ No proxies found. Check sources/")
		return
	}

	live := checkAsync(proxies)

	sort.Slice(live, func(i, j int) bool {
		return live[i].Latency < live[j].Latency
	})

	save(live)
	fmt.Println("✅ Finished. Results in proxyresult/")
}

func loadProxies() []string {
	cmd := exec.Command("bash", "-c",
		"grep -rhoE '[0-9]+\\.[0-9]+\\.[0-9]+\\.[0-9]+:[0-9]+' sources/ | sort -u",
	)
	out, _ := cmd.Output()
	return strings.Fields(string(out))
}

func checkAsync(list []string) []Proxy {
	jobs := make(chan string)
	results := make(chan Proxy)
	var wg sync.WaitGroup

	for i := 0; i < workers; i++ {
		wg.Add(1)
		go func() {
			defer wg.Done()
			for p := range jobs {
				start := time.Now()
				conn, err := net.DialTimeout("tcp", p, timeout)
				if err == nil {
					conn.Close()
					results <- Proxy{p, time.Since(start)}
				}
			}
		}()
	}

	go func() {
		for _, p := range list {
			jobs <- p
		}
		close(jobs)
		wg.Wait()
		close(results)
	}()

	var live []Proxy
	for r := range results {
		live = append(live, r)
	}
	return live
}

func save(list []Proxy) {
	files := map[string]*os.File{
		"http":   create("http.txt"),
		"socks4": create("socks4.txt"),
		"socks5": create("socks5.txt"),
	}

	for _, p := range list {
		for _, f := range files {
			fmt.Fprintln(f, p.Addr)
		}
	}
}

func create(name string) *os.File {
	f, _ := os.Create(filepath.Join("proxyresult", name))
	return f
}
