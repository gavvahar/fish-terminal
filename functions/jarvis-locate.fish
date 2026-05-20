function jarvis-locate
    if test (count $argv) -eq 0
        if test -n "$JARVIS_LOCATION"
            set_color cyan
            printf "  ◈ "
            set_color normal
            echo "Location: $JARVIS_LOCATION"
        else
            set_color cyan
            printf "  ◈ "
            set_color normal
            echo "No location set — using IP detection."
        end
    else if test "$argv[1]" = --clear
        set -Ue JARVIS_LOCATION
        set_color cyan
        printf "  ◈ "
        set_color normal
        echo "Location cleared. Falling back to IP detection."
    else
        set -Ux JARVIS_LOCATION (string join ' ' $argv)
        set_color cyan
        printf "  ◈ "
        set_color normal
        echo "Location set to: $JARVIS_LOCATION"
    end
end
