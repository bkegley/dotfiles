z() {
  if [ -n "$ZELLIJ" ]; then
    echo "Already inside a Zellij session"
    return 1
  fi

  local sessions
  sessions=$(zellij list-sessions -s 2>/dev/null)

  if [ -z "$sessions" ]; then
    printf "Session name (default: main): "
    read name
    name=${name:-main}
    if [ -f ".zellij.kdl" ]; then
      zellij -s "$name" --layout ./.zellij.kdl
    else
      zellij -s "$name"
    fi
    return
  fi

  local result
  result=$(echo "$sessions" | fzf \
    --header="enter=attach | ctrl-n=new | ctrl-x=kill" \
    --expect=ctrl-n,ctrl-x \
    --reverse \
    --height=40% \
    --border)

  [ -z "$result" ] && return

  local key=$(echo "$result" | head -1)
  local session=$(echo "$result" | sed -n '2p')

  case "$key" in
    ctrl-n)
      printf "Session name: "
      read name
      [ -z "$name" ] && return
      if [ -f ".zellij.kdl" ]; then
        zellij -s "$name" --layout ./.zellij.kdl
      else
        zellij -s "$name"
      fi
      ;;
    ctrl-x)
      [ -z "$session" ] && return
      zellij kill-session "$session"
      echo "Killed: $session"
      z
      ;;
    *)
      [ -z "$session" ] && return
      zellij attach "$session"
      ;;
  esac
}
