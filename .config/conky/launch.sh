#!/bin/sh

# Terminate all running bar insances
killall -q conky

# Wait till the processes have been shutdown
while pgrep -u $UID -x conky >/dev/null; do sleep 1; done

conky -c ~/.config/conky/config.conf -d