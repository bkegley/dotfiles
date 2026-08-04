# Tool activation only. PATH assembly lives in variables.sh, which is sourced
# AFTER this file — anything prepended here would be pushed down by it.

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Mise
#
# `mise activate` does NOT put a directory on PATH. It installs a precmd hook
# that rewrites PATH while preserving Homebrew's position, so for any tool both
# brew and mise provide (nvim, rg, bat, delta, fzf, starship, tmux, aws) the
# brew copy wins, and mise-only tools like jj never resolve at all.
#
# The shims dir in variables.sh is what actually makes mise win. activate is
# still wanted for per-directory version switching and env management.
#
# Resolved by ABSOLUTE path, not bare `mise`. PATH assembly lives in
# variables.sh, which is sourced AFTER this file, so ~/.local/bin is not on PATH
# yet here. A bare `mise` only works when it came from Homebrew (brew shellenv
# above puts /opt/homebrew/bin on PATH); a curl-installed mise in ~/.local/bin
# would silently fail with "command not found" and no shims, no activation.
# Checked in order so either install method works.
for _mise in "$HOME/.local/bin/mise" "/opt/homebrew/bin/mise"; do
  if [ -x "$_mise" ]; then
    if [ -n "$ZSH_VERSION" ]; then
      eval "$("$_mise" activate zsh)"
    else
      eval "$("$_mise" activate bash)"
    fi
    break
  fi
done
unset _mise

# Cargo
# The trailing `|| true` matters: this is the LAST statement in the file, so
# without it a missing ~/.cargo/env (rustup not installed yet) makes sourcing
# this file return 1 — which trips any caller running under `set -e`.
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env" || true
