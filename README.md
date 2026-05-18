# Fish Shell Config

My personal fish shell configuration.

## Dependencies

Install these first before cloning:

### Fish Shell

```bash
# Ubuntu/Debian
sudo apt install fish

# Mac
brew install fish

# Set as default shell
chsh -s $(which fish)
```

### Zoxide (smart cd)

```bash
# Ubuntu/Debian
sudo apt install zoxide

# Mac
brew install zoxide
```

### Fzf (fuzzy finder)

```bash
# Ubuntu/Debian
sudo apt install fzf

# Mac
brew install fzf
```

### Miniconda (optional)

Download from [docs.conda.io](https://docs.conda.io/en/latest/miniconda.html) and run the installer, then run:

```bash
conda init fish
```

### Bitwarden SSH Agent (optional)

Enable the SSH agent in Bitwarden desktop app settings.

## Install

Once dependencies are installed, clone this repo into your fish config directory:

```bash
git clone git@github.com:yourusername/fish-config.git ~/.config/fish
```

Then restart fish or run:

```fish
source ~/.config/fish/config.fish
```

## Quick Install

On a new machine, run:

```bash
curl -fsSL https://raw.githubusercontent.com/gavvahar/fish-terminal/main/install.sh | bash
```

This will:

1. Install fish, zoxide, and fzf
2. Optionally install Miniconda
3. Clone this config into `~/.config/fish`
4. Set fish as your default shell

After it completes, logout and login for all changes to take effect.

## Update config.fish only

To pull just the latest `config.fish` without changing anything else:

```bash
mkdir -p ~/.config/fish && curl -fsSL https://raw.githubusercontent.com/gavvahar/fish-terminal/main/config.fish -o ~/.config/fish/config.fish
```

Then reload it:

```fish
source ~/.config/fish/config.fish
```

That's it!
