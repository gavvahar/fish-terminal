function fish_command_not_found
    set_color cyan
    printf "  ◈ "
    set_color normal
    printf "Command not recognized: "
    set_color --bold white
    echo "'$argv[1]'"
    set_color normal
end
