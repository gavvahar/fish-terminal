#!/bin/bash

set -e  # exit on error

echo "🐟 Setting up Fish shell environment..."

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    OS="linux"
else
    echo "Unsupported OS: $OSTYPE"
    exit 1
fi

# ── Fish ──────────────────────────────────────────────────────────────────────
if command -v fish &>/dev/null; then
    echo "✅ Fish already installed"
else
    echo "Installing fish..."
    if [[ "$OS" == "mac" ]]; then
        brew install fish
    else
        sudo apt update && sudo apt install -y fish
    fi
    echo "✅ Fish installed"
fi

FISH_PATH=$(which fish)
if ! grep -q "$FISH_PATH" /etc/shells; then
    echo "$FISH_PATH" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != "$FISH_PATH" ]]; then
    chsh -s "$FISH_PATH"
    echo "✅ Fish set as default shell"
else
    echo "✅ Fish is already the default shell"
fi

# ── Zoxide ────────────────────────────────────────────────────────────────────
if command -v zoxide &>/dev/null; then
    echo "✅ Zoxide already installed"
else
    echo "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    echo "✅ Zoxide installed"
fi

# ── Fzf ───────────────────────────────────────────────────────────────────────
if command -v fzf &>/dev/null; then
    echo "✅ Fzf already installed"
else
    echo "Installing fzf..."
    if [[ "$OS" == "mac" ]]; then
        brew install fzf
    else
        sudo apt install -y fzf
    fi
    echo "✅ Fzf installed"
fi

# ── Miniconda ─────────────────────────────────────────────────────────────────
if command -v conda &>/dev/null; then
    echo "✅ Conda already installed"
else
    read -p "Install Miniconda? (y/n): " install_conda
    if [[ "$install_conda" == "y" ]]; then
        echo "Installing Miniconda..."
        if [[ "$OS" == "mac" ]]; then
            MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh"
        else
            MINICONDA_URL="https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh"
        fi
        curl -fsSL "$MINICONDA_URL" -o /tmp/miniconda.sh
        bash /tmp/miniconda.sh -b -p "$HOME/miniconda3"
        rm /tmp/miniconda.sh
        "$HOME/miniconda3/bin/conda" init fish
        echo "✅ Miniconda installed"
    else
        echo "⏭️  Skipping Miniconda"
    fi
fi

# ── Bitwarden SSH Agent ────────────────────────────────────────────────────────
echo ""
echo "⚠️  Bitwarden SSH Agent requires the Bitwarden desktop app."
echo "   Enable it manually: Settings → SSH Agent → Enable SSH Agent"
echo "   Then logout and login for the SSH_AUTH_SOCK to take effect."

# ── Fish Config ───────────────────────────────────────────────────────────────
if [[ -d "$HOME/.config/fish" && ! -d "$HOME/.config/fish/.git" ]]; then
    echo "Backing up existing fish config..."
    mv "$HOME/.config/fish" "$HOME/.config/fish.bak.$(date +%s)"
fi

if [[ ! -d "$HOME/.config/fish" ]]; then
    read -p "Enter your fish-config GitHub repo URL (SSH): " repo_url
    git clone "$repo_url" "$HOME/.config/fish"
    echo "✅ Fish config cloned"
else
    echo "✅ Fish config already in place"
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo "🎉 All done! Please logout and login (or reboot) to start using fish."
