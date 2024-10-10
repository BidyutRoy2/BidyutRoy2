#!/bin/bash

echo "-----------------------------------------------------------------------------"
curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash
echo "-----------------------------------------------------------------------------"

# Update and upgrade the package lists
echo "Updating and upgrading packages..."
sudo apt update && sudo apt upgrade -y

# Install necessary packages
echo "Installing required packages..."
sudo apt install -y \
  curl \
  iptables \
  build-essential \
  git \
  wget \
  lz4 \
  jq \
  make \
  gcc \
  nano \
  automake \
  autoconf \
  tmux \
  htop \
  nvme-cli \
  pkg-config \
  libssl-dev \
  libleveldb-dev \
  tar \
  clang \
  bsdmainutils \
  ncdu \
  unzip

echo "Installation complete."
