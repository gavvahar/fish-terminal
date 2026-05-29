#!/bin/bash

set -e

BASE="https://raw.githubusercontent.com/gavvahar/fish-terminal/main"

echo "── Step 1: Install Fish shell ───────────────────────────────────────────────"
curl -fsSL "$BASE/install-fish.sh" | bash

echo ""
echo "── Step 2: Clone Fish config ────────────────────────────────────────────────"
curl -fsSL "$BASE/install.sh" | bash

echo ""
echo "── Step 3: Install tools (Zoxide, Fzf) ─────────────────────────────────────"
curl -fsSL "$BASE/install-tools.sh" | bash

echo ""
echo "── Step 4: Install Conda ────────────────────────────────────────────────────"
curl -fsSL "$BASE/install-conda.sh" | bash

echo ""
echo "✅ Setup complete — restart your shell or open a new terminal"
