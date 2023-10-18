is_external_monitor_existing=$(xrandr | xrandr | grep "HDMI.*connected") 
echo has external monitor: $is_external_monitor_existing 
if [[ $is_external_monitor_existing ]]; then
    is_external_monitor_used=$(xrandr --listactivemonitors | grep HDMI) 
    echo external monitor used: $is_external_monitor_used 
    if ! [[ $is_external_monitor_used ]]; then
        echo switch to external monitor
        xrandr --output HDMI-0 --mode 2560x1440 --rate 143.86 --output DP-4 --off
    fi
fi
