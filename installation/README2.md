## If not installed use install command and if already installed use Upgrade command

-------------------------------------------------------------------------------------------------------------------------
### Installs git, curl, wget AND checks their versions after install
```
sudo apt update && sudo apt install -y git curl wget && echo -e "\n=== INSTALLED VERSIONS ===" && git --version && curl --version | head -n 1 && wget --version | head -n 1
```
---------------------------------------------------------------------------------------------------------------------------
### Install Packages
```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/Package.sh)
```
---------------------------------------------------------------------------------------------------------------------------
### Install Node js and npm
```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/node.sh)
```
### Upgrade Latest Version Node js and npm
```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/upgrade-node.sh)
```

### Check Version `node -v` & `npm -v`

-------------------------------------------------------------------------------------------------------------------------
### Install Docker & Compose
```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/docker.sh)
```
#### ======================= DOCKER Commands =======================
- Docker Service Status > `sudo systemctl status docker`
- List Containers:      > `docker ps -a`
- Filter by Name:       > `docker ps -f name=YOUR_NAME`
- Start Docker:         > `sudo systemctl enable --now docker`
- Restart Docker:       > `sudo systemctl restart docker`
- Check Versions:       > `docker --version && docker-compose --version`
- UNINSTALL EVERYTHING: > `sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras && sudo rm -rf /var/lib/docker /etc/docker /var/lib/containerd /usr/local/bin/docker-compose ~/.docker`
#### ==================================================================

### Upgrade Latest Version Docker & Compose
```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/docker-upgrade.sh)
```
### Check Version `docker --version` & `docker-compose --version`

### Uninstall & Delete Docker File
```
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras && sudo rm -rf /var/lib/docker /etc/docker /var/lib/containerd /usr/local/bin/docker-compose ~/.docker
```

---------------------------------------------------------------------------------------------------------------------------

### Install Rust
```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/rust.sh)
```
### Upgrade Latest Version Rust
```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/upgrade-rust.sh)
```

### Check Version `rustc --version` & `cargo --version`

---------------------------------------------------------------------------------------------------------------------------

### Install Foundry
```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/foundry.sh)
```
### Upgrade Latest Version Foundry

```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/upgrade-foundry.sh)
```

### Check Version `forge --version`

---------------------------------------------------------------------------------------------------------------------------


# ▄︻デ𝙂𝙚𝙩 𝙇𝙖𝙩𝙚𝙨𝙩 𝘼𝙞𝙧𝙙𝙧𝙤𝙥𝙨 & 𝙐𝙥𝙙𝙖𝙩𝙚𝙨═━一

### ▄︻デ𝙅𝙤𝙞𝙣 𝙏𝙚𝙡𝙚𝙜𝙧𝙖𝙢═━一 [🎀  𝐻𝒾𝒹𝒹𝑒𝓃 𝒢𝑒𝓂  🎀](https://t.me/hiddengemnews) 

### ░▒▓█►─═  𝓗𝓲𝒹ᗪ𝓔η Ǥέ𝕄 ═─◄█▓▒░

