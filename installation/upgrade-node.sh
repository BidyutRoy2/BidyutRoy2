#!/bin/bash

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

# Function to check if a command is available
check_command() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install NVM
install_nvm() {
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

    # Load NVM into the current shell
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
}

# Function to install or upgrade Node.js and npm
install_or_upgrade_node() {
    echo "Checking Node.js installation..."

    # Load NVM for the current session
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

    # Get the latest Node.js version
    LATEST_NODE=$(curl -s https://nodejs.org/dist/index.json | jq -r '.[0].version')

    # Check if Node.js is already installed
    if check_command "node"; then
        CURRENT_NODE=$(node -v)
        if [ "$CURRENT_NODE" != "$LATEST_NODE" ]; then
            echo "Upgrading Node.js from version $CURRENT_NODE to $LATEST_NODE..."
            nvm install "$LATEST_NODE" --reinstall-packages-from="$CURRENT_NODE"
        else
            echo "Node.js is already up-to-date (version $CURRENT_NODE)."
        fi
    else
        echo "Node.js is not installed."
        nvm install "$LATEST_NODE"
    fi

    # Ensure npm is installed with Node.js
    echo "Checking npm installation..."
    if ! check_command "npm"; then
        echo "npm is not installed. Installing npm..."
        nvm install-latest-npm
    else
        echo "npm is already installed (version $(npm -v))."
    fi
}

# Check if NVM is installed
if ! check_command "nvm"; then
    echo "NVM is not installed."
    install_nvm || { echo "NVM installation failed."; exit 1; }
else
    echo "NVM is already installed."
fi

# Install or upgrade Node.js and npm
install_or_upgrade_node || { echo "Node.js and npm installation or upgrade failed."; exit 1; }

# Verify installations
echo "Verifying installations..."
echo "Node.js version: $(node -v)"
echo "npm version: $(npm -v)"

echo "Node.js and npm installation or upgrade completed successfully!"
