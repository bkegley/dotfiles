# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Mise
if [ -n "$ZSH_VERSION" ]; then
  eval "$(mise activate zsh)"
else
  eval "$(mise activate bash)"
fi

# Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
