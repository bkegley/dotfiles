_zellij_layout_for() {
  local name="$1"
  local local_dir="$HOME/.config/zellij/layouts.local"
  local shared_dir="$HOME/.config/zellij/layouts"

  if [ -f "./.zellij.kdl" ]; then
    echo "./.zellij.kdl"
  elif [ -n "$name" ] && [ -f "$local_dir/$name.kdl" ]; then
    echo "$local_dir/$name.kdl"
  elif [ -n "$name" ] && [ -f "$shared_dir/$name.kdl" ]; then
    echo "$shared_dir/$name.kdl"
  elif [ -f "$shared_dir/repo.kdl" ]; then
    echo "$shared_dir/repo.kdl"
  fi
}

_zellij_bunyan_context() {
  local cwd="${1:-$PWD}"
  case "$cwd" in
    "$HOME/bunyan/workspaces/"*)
      local rest="${cwd#$HOME/bunyan/workspaces/}"
      local repo="${rest%%/*}"
      local worktree_and_more="${rest#*/}"
      local worktree="${worktree_and_more%%/*}"
      echo "$repo|$worktree"
      ;;
    *)
      echo ""
      ;;
  esac
}

z() {
  if [ -n "$ZELLIJ" ]; then
    echo "Already inside a Zellij session"
    return 1
  fi

  local ctx repo worktree session layout
  ctx="$(_zellij_bunyan_context)"

  if [ -n "$ctx" ]; then
    repo="${ctx%|*}"
    worktree="${ctx#*|}"
    session="$repo"
    layout="$(_zellij_layout_for "$repo")"

    if zellij list-sessions -s 2>/dev/null | grep -qx "$session"; then
      if zellij --session "$session" action list-tabs 2>/dev/null | grep -qE "^[0-9]+:? *$worktree( |$)"; then
        zellij --session "$session" action go-to-tab-name "$worktree"
      else
        zellij --session "$session" action new-tab \
          --name "$worktree" \
          ${layout:+--layout "$layout"} \
          --cwd "$PWD"
      fi
      zellij attach "$session"
    elif [ -n "$layout" ]; then
      zellij -n "$layout" -s "$session"
    else
      zellij -s "$session"
    fi
    return
  fi

  local sessions
  sessions=$(zellij list-sessions -s 2>/dev/null)

  if [ -z "$sessions" ]; then
    printf "Session name (default: main): "
    read name
    name=${name:-main}
    layout="$(_zellij_layout_for "$name")"
    if [ -n "$layout" ]; then
      zellij -n "$layout" -s "$name"
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
  local session_pick=$(echo "$result" | sed -n '2p')

  case "$key" in
    ctrl-n)
      printf "Session name: "
      read name
      [ -z "$name" ] && return
      layout="$(_zellij_layout_for "$name")"
      if [ -n "$layout" ]; then
        zellij -n "$layout" -s "$name"
      else
        zellij -s "$name"
      fi
      ;;
    ctrl-x)
      [ -z "$session_pick" ] && return
      zellij kill-session "$session_pick"
      echo "Killed: $session_pick"
      z
      ;;
    *)
      [ -z "$session_pick" ] && return
      zellij attach "$session_pick"
      ;;
  esac
}

_zellij_session_exists() {
  local session="$1"
  local list
  list=$(zellij list-sessions -s 2>/dev/null) || return 1
  echo "$list" | grep -qx "$session"
}

za() {
  if [ -n "$ZELLIJ" ]; then
    echo "Already inside a Zellij session"
    return 1
  fi

  local session="assistant"
  if _zellij_session_exists "$session"; then
    zellij attach "$session"
  else
    zellij --new-session-with-layout "$HOME/.config/zellij/layouts/assistant.kdl" --session "$session"
  fi
}
