#!/bin/bash

set -e

echo "Installing prerequisites..."
sudo apt update
sudo apt install -y unzip curl git fontconfig
echo "✅ Prerequisites installed"
