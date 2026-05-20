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
    # FIXED: Explicitly targeted user via sudo to prevent interactive PAM failures
    # when streaming / piping the deployment script over curl.
    sudo chsh -s "$FISH_PATH" "$USER"
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
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    # FIXED: Added --all flag to complete fzf installations cleanly without holding terminal prompt
    ~/.fzf/install --all
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
            curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-arm64.sh
            bash Miniconda3-latest-MacOSX-arm64.sh -b -p "$HOME/miniconda3"
            rm Miniconda3-latest-MacOSX-arm64.sh
        else
            curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
            bash Miniconda3-latest-Linux-x86_64.sh -b -p "$HOME/miniconda3"
            rm Miniconda3-latest-Linux-x86_64.sh
        fi
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
    read -p "Enter your fish-config GitHub repo URL (SSH) [Leave blank to skip]: " repo_url
    
    # FIXED: Wrapped git clone with safety block. Empty input string will safely 
    # generate a default configuration structure rather than triggering 'set -e' crashes.
    if [[ -n "$repo_url" ]]; then
        git clone "$repo_url" "$HOME/.config/fish"
        echo "✅ Fish config cloned"
    else
        echo "⏭️  Skipping config cloning, generating local structure..."
        mkdir -p "$HOME/.config/fish"
        touch "$HOME/.config/fish/config.fish"
    fi
else
    echo "✅ Fish config already in place"
fi

# ── Path and Integration Logic ─────────────────────────────────────────────────
# FIXED: Resolves "zoxide not found on $PATH" logic gate for local binaries.
if [[ -d "$HOME/.local/bin" ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Inject zoxide bindings into fish initialization configuration file
if [[ -f "$HOME/.config/fish/config.fish" ]]; then
    if ! grep -q "zoxide init fish" "$HOME/.config/fish/config.fish"; then
        echo -e "\n# Initialize Zoxide (z command)\nif command -v zoxide &>/dev/null\n    zoxide init fish | source\nend" >> "$HOME/.config/fish/config.fish"
    fi
    
    # Ensure fish permanently maintains awareness of local user binaries 
    if ! grep -q "fish_add_path ~/.local/bin" "$HOME/.config/fish/config.fish"; then
        echo -e "fish_add_path ~/.local/bin" >> "$HOME/.config/fish/config.fish"
    fi
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo "🎉 All done! Please logout and login (or reboot) to start using fish."
