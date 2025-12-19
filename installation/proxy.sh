#!/bin/bash

REPO_URL="https://github.com/BidyutRoy2/BidyutRoy2.git"
BRANCH="main"
FOLDER="proxy"
DEST="proxy"

echo "[+] Downloading only '$FOLDER' folder..."

# create temp workspace
TMP_DIR=$(mktemp -d)
cd "$TMP_DIR" || exit 1

git init -q
git remote add origin "$REPO_URL"
git config core.sparseCheckout true

mkdir -p .git/info
echo "$FOLDER/*" > .git/info/sparse-checkout

git pull -q origin "$BRANCH"

# move proxy folder to destination
mkdir -p "$OLDPWD/$DEST"
cp -r "$FOLDER/"* "$OLDPWD/$DEST/"

cd "$OLDPWD"
rm -rf "$TMP_DIR"

echo "[✓] Proxy folder downloaded successfully into ./$DEST"
