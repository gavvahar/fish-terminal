function fish_greeting
    set hour (date "+%H")

    if test $hour -lt 12
        set period "morning"
    else if test $hour -lt 17
        set period "afternoon"
    else
        set period "evening"
    end

    set datetime (date "+%A, %B %d %Y — %I:%M %p")
    set uptime_str (uptime -p 2>/dev/null | string replace 'up ' '')
    set interior 54

    set_color --bold cyan
    echo ""
    echo "  ╔══[ J.A.R.V.I.S. ]════════════════════════════════════╗"
    echo "  ║  Just A Rather Very Intelligent System               ║"
    echo "  ╠══════════════════════════════════════════════════════╣"
    set_color normal
    set_color cyan

    set l1 "  Good $period, "(whoami)"."
    set l2 "  $datetime"
    echo "  ║$l1"(string repeat -n (math $interior - (string length $l1)) " ")"║"
    echo "  ║$l2"(string repeat -n (math $interior - (string length $l2)) " ")"║"
    if test -n "$uptime_str"
        set l3 "  Uptime: $uptime_str"
        echo "  ║$l3"(string repeat -n (math $interior - (string length $l3)) " ")"║"
    end

    set_color --bold cyan
    echo "  ╠══════════════════════════════════════════════════════╣"
    echo "  ║  ◈ All systems operational.                          ║"
    echo "  ╚══════════════════════════════════════════════════════╝"
    set_color normal
    echo ""
end
