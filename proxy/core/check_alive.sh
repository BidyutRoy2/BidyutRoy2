#!/bin/bash
timeout=5
check() {
  while read p; do
    ip=$(echo $p | cut -d: -f1)
    port=$(echo $p | cut -d: -f2)
    nc -z -w$timeout $ip $port 2>/dev/null && echo "$p"
  done
}

echo "🔍 Checking HTTP..."
check < proxyresult/http.txt > proxyresult/http_live.txt

echo "🔍 Checking SOCKS4..."
check < proxyresult/socks4.txt > proxyresult/socks4_live.txt

echo "🔍 Checking SOCKS5..."
check < proxyresult/socks5.txt > proxyresult/socks5_live.txt

mv proxyresult/http_live.txt proxyresult/http.txt
mv proxyresult/socks4_live.txt proxyresult/socks4.txt
mv proxyresult/socks5_live.txt proxyresult/socks5.txt

rm -rf tmp
