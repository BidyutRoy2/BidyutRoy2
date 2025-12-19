#!/bin/bash
mkdir -p proxyresult tmp

find sources -type f -name "*.txt" -exec cat {} + > tmp/all.txt

grep -iE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+:[0-9]+' tmp/all.txt | sort -u > tmp/clean.txt

grep -i socks5 tmp/clean.txt > proxyresult/socks5.txt
grep -i socks4 tmp/clean.txt > proxyresult/socks4.txt
grep -iv socks tmp/clean.txt > proxyresult/http.txt

