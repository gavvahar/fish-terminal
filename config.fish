if status is-interactive
    zoxide init fish | source
    fzf --fish | source
    function zi
        set dir (zoxide query -l | fzf --query "$argv" --exact)
        if test -n "$dir"
            cd $dir
        end
    end
end

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
# <<< conda initialize <
