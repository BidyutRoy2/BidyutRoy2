## VIRTUALBOX SETTINGS — UBUNTU (24/7 STABLE)
-----
### GENERAL
- Name            : HiddenGem
- Type            : Linux
- Version         : Ubuntu (64-bit)
---
### SYSTEM → MOTHERBOARD
- Base Memory     : 8192 MB (8 GB)
- Boot Order      : Hard Disk, Optical
- Chipset         : ICH9
- Pointing Device : USB Tablet
- Use EFI         : Disabled
---
### SYSTEM → PROCESSOR
- Processors      : 4 CPU Cores
- Execution Cap   : 100%
- PAE/NX          : Enabled
---
### SYSTEM → ACCELERATION
- VT-x / AMD-V    : Enabled
- Nested Paging   : Enabled
- Paravirtualization Interface : KVM
---
### DISPLAY → SCREEN
- Graphics Controller : VMSVGA
- Video Memory        : 128 MB
- Enable 3D           : Disabled
---
### STORAGE
- Controller Type     : SATA
- Disk Type           : VDI
- Allocation          : Pre-allocate Full Size (Fixed)
- Disk Size           : 80–100 GB
- Optical Drive       : Removed
---
### NETWORK
- Adapter 1           : Enabled
- Attached to         : NAT
- Adapter Type        : Intel PRO/1000 MT Desktop
- Promiscuous Mode    : Deny
- Cable Connected     : Yes
---
### AUDIO
- Audio Enabled       : Optional
- Host Driver         : Default
- Controller          : ICH AC97
---
### USB
- USB Controller      : USB 2.0 (EHCI)
- Device Filters      : None
---
### SHARED FOLDERS
- Status              : Disabled (Enable only if needed)
---
### INSIDE UBUNTU — POWER SETTINGS
- Disable Sleep       : Enabled
- Idle Delay          : Disabled
---
### INSIDE UBUNTU — PERFORMANCE
- preload             : Installed
- swap                : Optional (4 GB if RAM < 16 GB)
- RESULT
- Uptime              : 24/7 Stable
- Recommended For     : Nodes, Bots, Server
-------------------------------------------------------------------------------------------------------------------------

### Enable Clipboard & Drag-Drop (VirtualBox Settings)

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

### Click "Devices" & Insert Guest additions CD Images

<img width="1064" height="624" alt="image" src="https://github.com/user-attachments/assets/5db1a864-b658-4e83-9322-9d06d553304b" />

```
sudo bash /media/$USER/VBox_GAs_*/VBoxLinuxAdditions.run
```

```
sudo reboot
```

### VirtualBox Quick Export vs Import Settings Without Install

| **EXPORT**           | **IMPORT**          |
| --------------------------- | --------------------------- |
| Power **OFF** VM            | Open VirtualBox             |
| File → **Export Appliance** | File → **Import Appliance** |
| Select VM                   | Select `.ova` file          |
| Format: **OVF 1.0**         | Review settings             |
| File name: `VM_Name.ova`    | Set **RAM / CPU**           |
| MAC: Include only **NAT**   | **EFI: OFF**                |
| Write Manifest: **ON**      | Network: **NAT**            |
| Include ISO: **OFF**        | Click **Import**            |
| Click **Finish**            | Start VM                    |


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
