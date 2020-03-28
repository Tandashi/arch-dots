#!/bin/sh

# Terminate all running bar insances
killall -q glava

# Wait till the processes have been shutdown
while pgrep -u $UID -x glava >/dev/null; do sleep 1; done

glava -d &