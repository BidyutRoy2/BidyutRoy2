Enable Clipboard & Drag-Drop (VirtualBox Settings)

------------------------------
- Right-click VM → Settings
- General → Advanced
- Shared Clipboard → Bidirectional
- Drag’n Drop → Bidirectional
------------------------------

```
sudo apt update
```

```
sudo apt install build-essential dkms linux-headers-$(uname -r) -y
```

Click "Devices" & Insert Guest additions CD Images

<img width="1064" height="624" alt="image" src="https://github.com/user-attachments/assets/5db1a864-b658-4e83-9322-9d06d553304b" />

```
sudo bash /media/$USER/VBox_GAs_*/VBoxLinuxAdditions.run
```

```
sudo reboot
```
## If not installed use install command For (Git, Curl, Wget, Node , NPM , Docker & More Packages)

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

### Upgrade Latest Version Docker & Compose
```bash
source <(wget -O - https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/refs/heads/main/installation/docker-upgrade.sh)
```
### Check Version `docker --version` & `docker-compose --version`

---------------------------------------------------------------------------------------------------------------------------
