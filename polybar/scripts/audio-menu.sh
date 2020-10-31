sink_count=$(pactl list sinks | grep "Sink #" | wc -l)

sink_description=$(pactl list sinks | awk '
/Description/ {$1=""; print $0}
' | rofi -dmenu -me-accept-entry 'MousePrimary' -me-select-entry 'MouseSecondary' -theme $HOME/.config/rofi/dropdown.rasi -yoffset 50 -xoffset -20 -location 3 -width 300 -lines $sink_count)

pactl list sinks | awk -v description="s*$sink_description" '
  /^Sink/ {sink_id = $2}
  $0 ~ description {print sink_id}
' | sed s\/#//g | xargs pactl set-default-sink
