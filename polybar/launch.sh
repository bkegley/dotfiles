#! /usr/bin/env bash

# Terminate running instances
killall -q polybar

# Wait until all processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar left &
polybar center &
polybar right &

