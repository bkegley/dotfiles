sink_description=$(pactl list sinks | awk '
/Description/ {$1=""; print $0}
' | rofi -dmenu -theme $HOME/.config/rofi/dropdown.rasi -yoffset 50 -xoffset -20 -location northeast)

pactl list sinks | awk -v descpription="s*$sink_description" '
  /^Sink/ {sink_id = $2}
  $0 ~ description {print sink_id}
' | sed s/\#//g | xargs pactl set-default-sink
