#!/bin/bash

# Function to log messages
log_message() {
    echo -e "\n[$(date +"%Y-%m-%d %H:%M:%S")] $1"
}

# Function to handle errors
handle_error() {
    log_message "❌ Error: $1"
    exit 1
}

# Function to check and install essential packages
install_essential_packages() {
    log_message "🔍 Checking and installing essential packages..."
    local packages=(
        "nvtop" "gnupg2" "gnupg1" "htop" "screen" "curl" "sudo" "wget" "fonts-noto" "fonts-noto-color-emoji"
        "fonts-dejavu" "fonts-freefont-ttf" "fonts-ubuntu" "fonts-roboto" "fonts-liberation"
    )

    for pkg in "${packages[@]}"; do
        if ! dpkg -l | grep -q "^ii  $pkg "; then
            log_message "📦 Installing $pkg..."
            sudo apt-get install -y "$pkg" || handle_error "Failed to install $pkg"
        else
            log_message "✅ $pkg is already installed."
        fi
    done

    log_message "✅ All essential packages are installed."
}

# Function to update and upgrade the system
update_system() {
    log_message "🔄 Updating and upgrading the system..."
    sudo apt-get update || handle_error "Failed to update package lists."
    sudo apt-get upgrade -y || handle_error "Failed to upgrade packages."
    sudo apt-get autoremove -y || handle_error "Failed to remove unused packages."
    log_message "✅ System updated and upgraded."
}

# Function to check NVIDIA GPU
check_nvidia_gpu() {
    log_message "🔍 Checking for NVIDIA GPU..."
    if ! command -v nvidia-smi &> /dev/null; then
        handle_error "NVIDIA GPU not detected! Install NVIDIA drivers first."
    fi
    log_message "✅ NVIDIA GPU detected!"
}

# Function to check if CUDA is installed and matches the required version
is_cuda_installed() {
    if command -v nvcc &> /dev/null; then
        CUDA_VERSION=$(nvcc --version | grep -oP 'release \K[0-9]+\.[0-9]+')
        REQUIRED_CUDA_VERSION="12.8"
        if [[ "$CUDA_VERSION" == "$REQUIRED_CUDA_VERSION" ]]; then
            log_message "✅ CUDA $REQUIRED_CUDA_VERSION is already installed!"
            return 0
        else
            log_message "⚠️ CUDA is installed, but the version ($CUDA_VERSION) does not match the required version ($REQUIRED_CUDA_VERSION)."
            return 1
        fi
    else
        log_message "❌ CUDA is not installed."
        return 1
    fi
}

# Function to set up CUDA environment variables
setup_cuda_env() {
    log_message "🔧 Setting up CUDA environment variables..."
    echo 'export PATH=/usr/local/cuda-12.8/bin${PATH:+:${PATH}}' | sudo tee /etc/profile.d/cuda.sh
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.8/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}' | sudo tee -a /etc/profile.d/cuda.sh
    source /etc/profile.d/cuda.sh
    log_message "✅ CUDA environment variables set up successfully."
}

# Function to install CUDA Toolkit 12.8 in WSL or Ubuntu 24.04
install_cuda() {
    if $IS_WSL; then
        echo "🖥️ Installing CUDA for WSL 2..."
        # Define file names and URLs for WSL
        PIN_FILE="cuda-wsl-ubuntu.pin"
        PIN_URL="https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-wsl-ubuntu.pin"
        DEB_FILE="cuda-repo-wsl-ubuntu-12-8-local_12.8.0-1_amd64.deb"
        DEB_URL="https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda-repo-wsl-ubuntu-12-8-local_12.8.0-1_amd64.deb"
    else
        echo "🖥️ Installing CUDA for Ubuntu 24.04..."
        # Define file names and URLs for Ubuntu 24.04
        PIN_FILE="cuda-ubuntu2404.pin"
        PIN_URL="https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2404/x86_64/cuda-ubuntu2404.pin"
        DEB_FILE="cuda-repo-ubuntu2404-12-8-local_12.8.0-570.86.10-1_amd64.deb"
        DEB_URL="https://developer.download.nvidia.com/compute/cuda/12.8.0/local_installers/cuda-repo-ubuntu2404-12-8-local_12.8.0-570.86.10-1_amd64.deb"
    fi

    # Download the .pin file
    echo "📥 Downloading $PIN_FILE from $PIN_URL..."
    wget "$PIN_URL" || { echo "❌ Failed to download $PIN_FILE from $PIN_URL"; exit 1; }

    # Move the .pin file to the correct location
    sudo mv "$PIN_FILE" /etc/apt/preferences.d/cuda-repository-pin-600 || { echo "❌ Failed to move $PIN_FILE to /etc/apt/preferences.d/"; exit 1; }

    # Remove the .deb file if it exists, then download a fresh copy
    if [ -f "$DEB_FILE" ]; then
        echo "🗑️ Deleting existing $DEB_FILE..."
        rm -f "$DEB_FILE"
    fi
    echo "📥 Downloading $DEB_FILE from $DEB_URL..."
    wget "$DEB_URL" || { echo "❌ Failed to download $DEB_FILE from $DEB_URL"; exit 1; }

    # Install the .deb file
    sudo dpkg -i "$DEB_FILE" || { echo "❌ Failed to install $DEB_FILE"; exit 1; }

    # Copy the keyring
    sudo cp /var/cuda-repo-*/cuda-*-keyring.gpg /usr/share/keyrings/ || { echo "❌ Failed to copy CUDA keyring to /usr/share/keyrings/"; exit 1; }

    # Update the package list and install CUDA Toolkit 12.8
    echo "🔄 Updating package list..."
    sudo apt-get update || { echo "❌ Failed to update package list"; exit 1; }
    echo "🔧 Installing CUDA Toolkit 12.8..."
    sudo apt-get install -y cuda-toolkit-12-8 || { echo "❌ Failed to install CUDA Toolkit 12.8"; exit 1; }

    echo "✅ CUDA Toolkit 12.8 installed successfully."
    setup_cuda_env
}

# Main script execution
log_message "🚀 Starting system setup..."
# Check and install essential packages
install_essential_packages
# Check for NVIDIA GPU
check_nvidia_gpu
# Install CUDA if not already installed
setup_cuda_env
install_cuda
setup_cuda_env
is_cuda_installed
# Update and upgrade the system
update_system

log_message "🎉 Cuda setup completed successfully!"
