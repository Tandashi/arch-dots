#!/bin/sh

# Terminate all running bar insances
killall -q sxhkd

# Wait till the processes have been shutdown
while pgrep -u $UID -x sxhkd >/dev/null; do sleep 1; done

sxhkd &