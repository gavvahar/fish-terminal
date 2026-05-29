#!/bin/bash

set -e

BASE="https://raw.githubusercontent.com/gavvahar/fish-terminal/main"

echo "── Step 1: Install Fish shell ───────────────────────────────────────────────"
curl -fsSL "$BASE/install-fish.sh" | bash

echo ""
echo "── Step 2: Clone Fish config ────────────────────────────────────────────────"
curl -fsSL "$BASE/install.sh" | bash

echo ""
read -rp "── Step 3: Install tools (Zoxide, Fzf)? [y/N] " tools
if [[ "$tools" =~ ^[Yy]$ ]]; then
    curl -fsSL "$BASE/install-tools.sh" | bash
else
    echo "Skipping tools install"
fi

echo ""
read -rp "── Step 4: Install Conda? [y/N] " conda
if [[ "$conda" =~ ^[Yy]$ ]]; then
    curl -fsSL "$BASE/install-conda.sh" | bash
else
    echo "Skipping Conda install"
fi

echo ""
echo "✅ Setup complete — restart your shell or open a new terminal"
