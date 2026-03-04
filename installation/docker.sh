#!/bin/bash
set -e

# Logo Header
echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

# Function to check if a command exists
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# 1. Install Docker Engine
install_docker() {
    echo "--- Installing Docker ---"
    sudo apt-get update
    sudo apt-get install -y ca-certificates curl gnupg
    
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    sudo apt-get update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
}

# 2. Install Docker Compose Standalone (The binary)
install_docker_compose() {
    echo "--- Installing Docker Compose (Standalone) ---"
    LATEST_COMPOSE=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    sudo curl -L "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

# Execute Installation if missing
if ! check_command "docker"; then install_docker; else echo "Docker is already installed."; fi
if ! check_command "docker-compose"; then install_docker_compose; else echo "Docker Compose is already installed."; fi

# 3. Start and Enable Services
echo "--- Starting Docker Service ---"
sudo systemctl enable --now docker
sudo systemctl restart docker
sudo usermod -aG docker $USER 2>/dev/null || true

# 4. Verification & Status
echo "Check Docker Service Status:"
sudo systemctl status docker --no-pager

# 5. Interactive Dashboard
show_menu() {
    echo ""
    echo "======================= DOCKER HELP CENTER ======================="
    echo " [1] List all containers (docker ps -a)"
    echo " [2] Filter containers by name"
    echo " [3] Restart Docker Service"
    echo " [4] Check Versions"
    echo " [5] UNINSTALL & DELETE EVERYTHING (Warning!)"
    echo " [6] Exit Dashboard"
    echo "================================================================"
    read -p "Choose an option [1-6]: " choice

    case $choice in
        1) docker ps -a; show_menu ;;
        2) read -p "Enter name to filter: " cname; docker ps -f name=$cname; show_menu ;;
        3) sudo systemctl restart docker; echo "Docker restarted."; show_menu ;;
        4) docker --version && docker-compose --version; show_menu ;;
        5) 
            read -p "Delete all Docker data? (y/n): " confirm
            if [[ $confirm == [yY] ]]; then
                sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
                sudo rm -rf /var/lib/docker /etc/docker /var/lib/containerd /usr/local/bin/docker-compose ~/.docker
                echo "Docker removed completely."; exit 0
            fi
            show_menu ;;
        6) echo "Exiting...";;
        *) echo "Invalid option."; show_menu ;;
    esac
}

show_menu

# Final Logo
echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"
