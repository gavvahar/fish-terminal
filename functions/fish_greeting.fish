function fish_greeting
    set datetime (date "+%A, %B %d %Y — %I:%M %p")
    set uptime_str (uptime -p 2>/dev/null | string replace 'up ' '')
    set interior 54

    set_color --bold FF0090
    echo ""
    echo "  ╔══[ TOKYO DRIFT ]═══════════════════════════════════════╗"
    set_color normal
    set_color 00d4ff
    set l1 "  "(whoami)
    echo "  ║$l1"(string repeat -n (math $interior - (string length $l1)) " ")"  ║"
    set l2 "  $datetime"
    echo "  ║$l2"(string repeat -n (math $interior - (string length $l2)) " ")"  ║"
    if test -n "$uptime_str"
        set_color 00ff41
        set l3 "  ↑ $uptime_str"
        echo "  ║$l3"(string repeat -n (math $interior - (string length $l3)) " ")"  ║"
    end
    set_color --bold FF0090
    echo "  ╚════════════════════════════════════════════════════════╝"
    set_color normal
    echo ""
end
