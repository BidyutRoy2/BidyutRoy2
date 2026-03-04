#!/bin/bash
set -e

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

check_command() {
    command -v "$1" >/dev/null 2>&1
}

install_docker() {
    echo "Installing Docker..."
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

install_docker_compose() {
    echo "Installing Docker Compose Standalone..."
    LATEST_COMPOSE=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    sudo curl -L "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

if ! check_command "docker"; then install_docker; else echo "Docker already installed."; fi
if ! check_command "docker-compose"; then install_docker_compose; else echo "Compose already installed."; fi

echo "Starting Docker Service..."
sudo systemctl enable --now docker
sudo systemctl restart docker

echo "Check Docker Service Status:"
sudo systemctl status docker --no-pager

echo ""
echo " ======================= DOCKER Commands ======================="
echo "1. List Containers:      > docker ps -a"
echo "2. Filter by Name:       > docker ps -f name=YOUR_NAME"
echo "3. Start Docker:         > sudo systemctl enable --now docker"
echo "4. Restart Docker:       > sudo systemctl restart docker"
echo "5. Check Versions:       > docker --version && docker-compose --version"
echo "6. UNINSTALL EVERYTHING: > sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras && sudo rm -rf /var/lib/docker /etc/docker /var/lib/containerd /usr/local/bin/docker-compose ~/.docker"
echo "=================================================================="
echo ""

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"
