export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"

export EDITOR="nvim"
export TERMINAL="ghostty"
export TERM="xterm-256color"

# PATH assembly. This file is sourced AFTER init.sh, so it has the final say —
# keep all PATH manipulation here rather than splitting it across both files.
#
# Order matters, lowest precedence first:
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.bun/bin:$PATH"

# mise shims LAST so they take precedence over Homebrew.
#
# `mise activate` (in init.sh) does not prepend a shims dir — it rewrites PATH
# preserving brew's position — so without this, /opt/homebrew/bin shadows every
# tool mise manages and mise-only tools (jj) never resolve.
#
# Shims also work in non-interactive contexts activate does not cover well:
# scripts, editors spawning subprocesses, launchd agents.
export PATH="$XDG_DATA_HOME/mise/shims:$PATH"
