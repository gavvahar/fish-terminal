# Fish Shell Config

My personal fish shell configuration.

## Dependencies

Install these first before cloning:

### Fish Shell

```bash
curl -fsSL https://raw.githubusercontent.com/gavvahar/fish-terminal/main/install-fish.sh | bash
```

This will install fish, add it to `/etc/shells`, and set it as your default shell.

### Starship (prompt)

```bash
curl -sS https://starship.rs/install.sh | sh
```

### Zoxide & Fzf

```bash
curl -fsSL https://raw.githubusercontent.com/gavvahar/fish-terminal/main/install-tools.sh | bash
```

### Miniconda (optional)

```bash
curl -fsSL https://raw.githubusercontent.com/gavvahar/fish-terminal/main/install-conda.sh | bash
```

This will install Miniconda if not already installed, run `conda init fish`, and disable auto-activation of the base environment.

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

This will back up any existing fish config and clone this repo into `~/.config/fish`.

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
