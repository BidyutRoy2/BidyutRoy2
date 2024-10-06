#!/bin/bash

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

# Function to check if a command is available
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install or upgrade Docker
install_or_upgrade_docker() {
    echo "Checking Docker installation..."
    
    # Update the package index
    sudo apt-get update

    # Install required packages
    sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

    # Add Docker’s official GPG key
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # Set up the stable repository
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

    # Update the package index again
    sudo apt-get update

    # Install or upgrade Docker
    sudo apt-get install -y docker-ce
}

# Function to install or upgrade Docker Compose
install_or_upgrade_docker_compose() {
    echo "Checking Docker Compose installation..."
    
    # Fetch the latest version number
    LATEST_COMPOSE=$(curl -s https://github.com/docker/compose/releases/latest | sed 's/.*\///')

    # Check if Docker Compose is already installed
    if check_command "docker-compose"; then
        CURRENT_COMPOSE=$(docker-compose --version | awk '{print $3}' | sed 's/,//')
        if [ "$CURRENT_COMPOSE" != "$LATEST_COMPOSE" ]; then
            echo "Upgrading Docker Compose from version $CURRENT_COMPOSE to $LATEST_COMPOSE..."
        else
            echo "Docker Compose is already up-to-date (version $CURRENT_COMPOSE)."
            return
        fi
    else
        echo "Docker Compose is not installed."
    fi

    # Download Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/download/${LATEST_COMPOSE}/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    
    # Apply executable permissions to the Docker Compose binary
    sudo chmod +x /usr/local/bin/docker-compose
}

# Check if Docker is installed
if ! check_command "docker"; then
    echo "Docker is not installed."
    install_or_upgrade_docker || { echo "Docker installation failed."; exit 1; }
else
    echo "Docker is already installed."
    install_or_upgrade_docker || { echo "Docker upgrade failed."; exit 1; }
fi

# Install or upgrade Docker Compose
install_or_upgrade_docker_compose || { echo "Docker Compose installation or upgrade failed."; exit 1; }

# Verify installations
echo "Verifying installations..."
echo "Docker version: $(docker --version)"
echo "Docker Compose version: $(docker-compose --version)"

echo "Docker and Docker Compose installation or upgrade completed successfully!"
