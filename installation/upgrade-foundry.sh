#!/bin/bash

# Function to check if a command is available
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install or upgrade Foundry
install_or_upgrade_foundry() {
    echo "Checking Foundry installation..."

    if check_command "foundryup"; then
        echo "Foundry is already installed. Checking for updates..."
        foundryup update
    else
        echo "Foundry is not installed. Installing Foundry..."
        curl -L https://foundry.paradigm.xyz | bash
        # Load Foundry environment
        source $HOME/.bashrc
        echo "Foundry installed successfully."
    fi
}

# Check if Foundry is installed and install or upgrade
install_or_upgrade_foundry || { echo "Foundry installation or upgrade failed."; exit 1; }

# Verify installation
echo "Verifying Foundry installation..."
echo "Foundry version: $(forge --version)"

echo "Foundry installation or upgrade completed successfully!"
