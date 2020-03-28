#!/bin/sh

# Terminate all running bar insances
killall -q polybar

# Wait till the processes have been shutdown
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launche polybar, using the config at ~/.config/polybar/config
polybar -c ~/.config/polybar/config.ini main_dp0 &
polybar -c ~/.config/polybar/config.ini main_hdmi0 &

echo "Polybar launched..."

