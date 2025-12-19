#!/bin/bash
set -e

# ================== SHOW LOGO ==================
echo "-----------------------------------------------------------------------------"
if curl -fsSL https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash; then
  echo "[✓] Logo loaded successfully"
else
  echo "[!] Failed to load logo (continuing anyway)"
fi
echo "-----------------------------------------------------------------------------"
sleep 2

# ================== HELPERS ==================
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# ================== UPDATE SYSTEM ==================
echo "[+] Updating system..."
sudo apt update -y

# ================== CHECK & INSTALL GIT ==================
if ! command_exists git; then
  echo "[+] Installing git..."
  sudo apt install -y git
else
  echo "[✓] git already installed"
fi

# ================== CHECK & INSTALL CURL ==================
if ! command_exists curl; then
  echo "[+] Installing curl..."
  sudo apt install -y curl
else
  echo "[✓] curl already installed"
fi

# ================== CHECK & INSTALL NODEJS ==================
if ! command_exists node; then
  echo "[+] Installing Node.js (LTS)..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
  sudo apt install -y nodejs
else
  echo "[✓] Node.js already installed"
fi

# ================== CHECK & INSTALL NPM ==================
if ! command_exists npm; then
  echo "[+] Installing npm..."
  sudo apt install -y npm
else
  echo "[+] Updating npm to latest..."
  sudo npm install -g npm@latest >/dev/null 2>&1
fi

# ================== CHECK & INSTALL GO ==================
GO_VERSION_REQUIRED="1.21.6"
INSTALL_GO=false

if command_exists go; then
  GO_CURRENT=$(go version | awk '{print $3}' | sed 's/go//')
  if [ "$GO_CURRENT" != "$GO_VERSION_REQUIRED" ]; then
    echo "[!] Go version mismatch (found $GO_CURRENT, required $GO_VERSION_REQUIRED)"
    INSTALL_GO=true
  else
    echo "[✓] Go $GO_VERSION_REQUIRED already installed"
  fi
else
  INSTALL_GO=true
fi

if [ "$INSTALL_GO" = true ]; then
  echo "[+] Installing Go $GO_VERSION_REQUIRED..."
  cd /tmp
  wget -q https://go.dev/dl/go${GO_VERSION_REQUIRED}.linux-amd64.tar.gz
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf go${GO_VERSION_REQUIRED}.linux-amd64.tar.gz
  rm -f /tmp/go${GO_VERSION_REQUIRED}.linux-amd64.tar.gz
fi

# ================== SET GO PATH ==================
if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
fi
export PATH=$PATH:/usr/local/go/bin
source ~/.bashrc

# ================== VERSION CHECK ==================
echo "=========================================="
echo " Installed Versions"
echo "------------------------------------------"
git --version
curl --version | head -n 1
node --version
npm --version
go version
echo "=========================================="

# ================== DOWNLOAD proxy-auto-collector ONLY ==================
echo "[+] Downloading proxy-auto-collector..."

REPO_URL="https://github.com/BidyutRoy2/BidyutRoy2.git"
BRANCH="main"
TARGET_DIR="proxy-auto-collector"

TMP_DIR=$(mktemp -d)
cd "$TMP_DIR"

git init -q
git remote add origin "$REPO_URL"
git config core.sparseCheckout true

mkdir -p .git/info
echo "$TARGET_DIR/*" > .git/info/sparse-checkout

git pull -q origin "$BRANCH"

cd - >/dev/null

rm -rf "$TARGET_DIR"
mv "$TMP_DIR/$TARGET_DIR" ./
rm -rf "$TMP_DIR"

# ================== DONE ==================
echo "=========================================="
echo "[✓] All checks completed successfully"
echo "[✓] Folder ready: ./$TARGET_DIR"
echo "[✓] Environment is healthy & ready"
echo "=========================================="
