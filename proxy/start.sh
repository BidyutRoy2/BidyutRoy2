#!/bin/bash
chmod +x core/*.sh
./core/fetch.sh
./core/merge.sh
./core/check_alive.sh
echo "✅ Finished: Live proxies saved in proxyresult/"

