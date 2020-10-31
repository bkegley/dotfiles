if [ -d /sys/class/power_supply/BAT1 ]; then
  cat /sys/class/power_supply/BAT1/capacity | xargs printf "%d%%"
else
  echo ""
fi
