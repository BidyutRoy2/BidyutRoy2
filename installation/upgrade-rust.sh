#!/bin/bash

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

# Function to check if a command is available
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install or upgrade Rust
install_or_upgrade_rust() {
    echo "Checking Rust installation..."

    if check_command "rustup"; then
        echo "Rust is already installed. Checking for updates..."
        rustup update
    else
        echo "Rust is not installed. Installing Rust..."
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

        # Load Rust environment
        export PATH="$HOME/.cargo/bin:$PATH"
        echo "Rust installed successfully."
    fi
}

# Check if Rust is installed and install or upgrade
install_or_upgrade_rust || { echo "Rust installation or upgrade failed."; exit 1; }

# Verify installation
echo "Verifying Rust installation..."
echo "Rust version: $(rustc --version)"
echo "Cargo version: $(cargo --version)"

echo "Rust installation or upgrade completed successfully!"
