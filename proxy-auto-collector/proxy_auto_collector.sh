#!/bin/bash

set -o pipefail

error_exit() {
  echo "[✗] ERROR: $1"
  exit 1
}

# ================= SHOW LOGO =================
echo "-----------------------------------------------------------------------------"
curl -fsSL https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash || \
echo "[!] Logo load failed (ignored)"
echo "-----------------------------------------------------------------------------"
sleep 2

# ================= WORK DIRECTORY =================
BASE_DIR="$HOME/proxy_auto_collector"
TARGET_DIR="proxy-auto-collector"
REPO_URL="https://github.com/BidyutRoy2/BidyutRoy2.git"

mkdir -p "$BASE_DIR"
cd "$BASE_DIR" || error_exit "Cannot access $BASE_DIR"

echo "[✓] Working directory: $BASE_DIR"

# ================= HELPERS =================
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# ================= SUDO CHECK =================
sudo -v || error_exit "Sudo authentication failed"

# ================= UPDATE SYSTEM =================
echo "[+] Updating system..."
sudo apt-get update -y || error_exit "apt-get update failed"

# ================= INSTALL REQUIRED TOOLS =================
for pkg in git curl wget tar; do
  if ! command_exists "$pkg"; then
    echo "[+] Installing $pkg..."
    sudo apt-get install -y "$pkg" || error_exit "Failed to install $pkg"
  else
    echo "[✓] $pkg already installed"
  fi
done

# ================= NODEJS =================
if ! command_exists node; then
  echo "[+] Installing Node.js (LTS)..."
  curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash - \
    || error_exit "NodeSource setup failed"
  sudo apt-get install -y nodejs || error_exit "Node.js install failed"
else
  echo "[✓] Node.js already installed"
fi

# ================= NPM (SAFE) =================
if ! command_exists npm; then
  echo "[+] Installing npm..."
  sudo apt-get install -y npm || error_exit "npm install failed"
else
  echo "[✓] npm already installed"
fi

# ================= GO =================
GO_VERSION_REQUIRED="1.21.6"
INSTALL_GO=false

if command_exists go; then
  GO_CURRENT=$(go version | awk '{print $3}' | sed 's/go//')
  if [ "$GO_CURRENT" != "$GO_VERSION_REQUIRED" ]; then
    INSTALL_GO=true
  fi
else
  INSTALL_GO=true
fi

if [ "$INSTALL_GO" = true ]; then
  echo "[+] Installing Go $GO_VERSION_REQUIRED..."
  cd /tmp || error_exit "Cannot access /tmp"
  wget -q https://go.dev/dl/go${GO_VERSION_REQUIRED}.linux-amd64.tar.gz \
    || error_exit "Go download failed"
  sudo rm -rf /usr/local/go
  sudo tar -C /usr/local -xzf go${GO_VERSION_REQUIRED}.linux-amd64.tar.gz \
    || error_exit "Go extract failed"
  rm -f go${GO_VERSION_REQUIRED}.linux-amd64.tar.gz
  cd "$BASE_DIR"
else
  echo "[✓] Go $GO_VERSION_REQUIRED already installed"
fi

# ================= GO PATH =================
if ! grep -q "/usr/local/go/bin" ~/.bashrc; then
  echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
fi
export PATH=$PATH:/usr/local/go/bin

# ================= VERSION CHECK =================
echo "=========================================="
echo " Installed Versions"
echo "------------------------------------------"
git --version
curl --version | head -n 1
node --version
npm --version
go version
echo "=========================================="

# ================= COPY proxy-auto-collector =================
echo "[+] Copying proxy-auto-collector folder..."

rm -rf "$TARGET_DIR"

git init -q "$TARGET_DIR"
cd "$TARGET_DIR" || error_exit "cd failed"

git remote add origin "$REPO_URL"
git config core.sparseCheckout true

mkdir -p .git/info
echo "$TARGET_DIR/*" > .git/info/sparse-checkout

git pull -q origin main || error_exit "Git pull failed"

# remove git metadata (keep files only)
rm -rf .git

cd "$BASE_DIR"

# ================= DONE =================
echo "=========================================="
echo "[✓] SUCCESS"
echo "[✓] Installed tools: git, curl, nodejs, npm, go"
echo "[✓] Folder ready: $BASE_DIR/$TARGET_DIR"
echo "[✓] No temp directory used"
echo "=========================================="
