#!/bin/bash

set -e

echo "[INFO] Updating Debian..."
sudo apt update -y && apt upgrade -y

echo "[INFO] Installing Chromium + required libraries..."
sudo apt install -y \
  chromium \
  chromium-driver \
  nodejs \
  npm \
  libatk-bridge2.0-0 \
  libgtk-3-0 \
  libasound2 \
  libnss3 \
  libxss1 \
  libgbm1 \
  libatk1.0-0 \
  libatk-adaptor \
  libxdamage1 \
  libxcomposite1 \
  libxrandr2 \
  libxkbcommon0 \
  libpango-1.0-0 \
  libcups2 \
  libdrm2 \
  libxshmfence1 \
  libxfixes3 \
  libx11-xcb1 \
  libx11-6 \
  libxext6 \
  libxrender1 \
  libxi6 \
  libxcursor1 \
  libglib2.0-0

echo "[INFO] Installing Puppeteer-Core..."
npm install puppeteer-core

echo "[INFO] Detecting installed Chromium path..."

if [ -f /usr/bin/chromium ]; then
    echo "[INFO] Chromium detected: /usr/bin/chromium"
elif [ -f /usr/bin/chromium-browser ]; then
    echo "[INFO] Chromium detected: /usr/bin/chromium-browser"
else
    echo "[ERROR] Chromium executable not found!"
    exit 1
fi

rm -rf setup_nodejs.sh

echo ""
echo "======================================="
echo "  INSTALL COMPLETE!"
echo "  Dependencies for Puppeteer installed."
echo "  Chromium is ready to use."
echo "======================================="
