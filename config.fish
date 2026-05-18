# 1. Ensure Fish can find zoxide and other local binaries
fish_add_path $HOME/.local/bin

if status is-interactive
    # 2. Initialize zoxide (this automatically creates the native 'z' and 'zi' commands)
    zoxide init fish | source
    
    # 3. Enable fzf keybindings and completions
    fzf --fish | source
end

# 4. Bitwarden SSH Agent Connection
if test -S $HOME/.bitwarden-ssh-agent.sock
    set -x SSH_AUTH_SOCK $HOME/.bitwarden-ssh-agent.sock
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f $HOME/miniconda3/bin/conda
    eval $HOME/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
        . "$HOME/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "$HOME/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<