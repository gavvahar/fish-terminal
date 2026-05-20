function brief
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
    set mem_info (free -h 2>/dev/null | awk '/^Mem:/ {print $3 "/" $2}')
    set cpu_load (cat /proc/loadavg 2>/dev/null | awk '{print $1}')
    set disk_root (df -h / 2>/dev/null | awk 'NR==2 {print $3 "/" $2 " (" $5 ")"}')
    set ip_addr (ip route get 1 2>/dev/null | awk 'NR==1 {for(i=1;i<=NF;i++) if ($i=="src") {print $(i+1); exit}}')
    set weather_lines
    if test (count $JARVIS_LOCATIONS) -gt 0
        for loc in $JARVIS_LOCATIONS
            set w (python3 ~/.config/fish/get_weather.py $loc 2>/dev/null)
            if test -n "$w"
                set weather_lines $weather_lines $w
            end
        end
    else
        set w (python3 ~/.config/fish/get_weather.py 2>/dev/null)
        if test -n "$w"
            set weather_lines $w
        end
    end

    set interior 54
    set sep (string repeat -n $interior "═")
    set hdr "══[ J.A.R.V.I.S. BRIEF ]"
    set hdr_fill (string repeat -n (math $interior - (string length $hdr)) "═")

    set_color --bold cyan
    echo ""
    echo "  ╔$hdr$hdr_fill╗"
    set_color cyan
    echo "  ║"(string pad -r -w $interior "  Good $period. Here is your briefing.")"║"
    echo "  ║"(string pad -r -w $interior "  $datetime")"║"
    if test (count $weather_lines) -gt 0
        echo "  ║"(string pad -r -w $interior "")"║"
        if test (count $weather_lines) -eq 1
            echo "  ║"(string pad -r -w $interior "  Weather:  $weather_lines[1]")"║"
        else
            echo "  ║"(string pad -r -w $interior "  Weather:")"║"
            for w in $weather_lines
                echo "  ║"(string pad -r -w $interior "    $w")"║"
            end
        end
    end
    set_color --bold cyan
    echo "  ╠$sep╣"
    set_color cyan
    echo "  ║"(string pad -r -w $interior "  Uptime:   $uptime_str")"║"
    echo "  ║"(string pad -r -w $interior "  Memory:   $mem_info")"║"
    echo "  ║"(string pad -r -w $interior "  CPU:      $cpu_load")"║"
    echo "  ║"(string pad -r -w $interior "  Disk /:   $disk_root")"║"
    if test -n "$ip_addr"
        echo "  ║"(string pad -r -w $interior "  Network:  $ip_addr")"║"
    end
    set_color --bold cyan
    echo "  ╚$sep╝"
    set_color normal
    echo ""
end
