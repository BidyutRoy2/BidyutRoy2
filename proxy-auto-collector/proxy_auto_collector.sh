#!/bin/bash

REPO_URL="https://github.com/BidyutRoy2/BidyutRoy2.git"
BRANCH="main"
TARGET_DIR="proxy-auto-collector"

echo "[+] Downloading only '$TARGET_DIR' folder..."

TMP_DIR=$(mktemp -d)
cd "$TMP_DIR" || exit 1

git init -q
git remote add origin "$REPO_URL"

git config core.sparseCheckout true
mkdir -p .git/info
echo "$TARGET_DIR/*" > .git/info/sparse-checkout

git pull -q origin "$BRANCH"

cd - >/dev/null || exit 1
rm -rf "$TARGET_DIR"
mv "$TMP_DIR/$TARGET_DIR" ./

rm -rf "$TMP_DIR"

echo "[✓] Done! '$TARGET_DIR' downloaded successfully."
