#!/bin/bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
PLATFORM="$(uname -s)"

symlink_file() {
  ln -sf "$1" "$2"
}

symlink_dir() {
  if [ -e "$2" ] && [ ! -L "$2" ]; then
    echo "WARNING: $2 exists and is not a symlink, skipping"
    return
  fi
  ln -sfn "$1" "$2"
}

mkdir -p "$HOME/.config"

# === Cross-platform ===

# Umbrella dirs
symlink_dir "$DOTFILES/shell" "$HOME/.config/shell"
symlink_dir "$DOTFILES/ghostty" "$HOME/.config/ghostty"
symlink_dir "$DOTFILES/zellij" "$HOME/.config/zellij"
symlink_dir "$DOTFILES/nvim" "$HOME/.config/nvim"
symlink_dir "$DOTFILES/tmux" "$HOME/.config/tmux"
symlink_dir "$DOTFILES/mise" "$HOME/.config/mise"

# Files
symlink_file "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
[ -f "$DOTFILES/zsh/.zsh_local" ] && symlink_file "$DOTFILES/zsh/.zsh_local" "$HOME/.zsh_local"
symlink_file "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
symlink_file "$DOTFILES/git/.gitignore_global" "$HOME/.gitignore_global"
symlink_file "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

# === macOS ===
if [ "$PLATFORM" = "Darwin" ]; then
  symlink_dir "$DOTFILES/karibener" "$HOME/.config/karabiner"
fi

# === Linux ===
if [ "$PLATFORM" = "Linux" ]; then
  # Xorg
  mkdir -p "$HOME/.Xresources.d"
  symlink_file "$DOTFILES/.Xoverrides" "$HOME/.Xresources.d/overrides"
  symlink_file "$DOTFILES/.Xresources" "$HOME/.Xresources"
  symlink_file "$DOTFILES/.xinitrc" "$HOME/.xinitrc"

  # Bash
  symlink_file "$DOTFILES/bash/.bashrc" "$HOME/.bashrc"
  symlink_file "$DOTFILES/bash/.bash_aliases" "$HOME/.bash_aliases"
  [ -f "$DOTFILES/bash/.bash_local" ] && symlink_file "$DOTFILES/bash/.bash_local" "$HOME/.bash_local"

  # Window manager / desktop
  symlink_dir "$DOTFILES/i3" "$HOME/.config/i3"
  symlink_dir "$DOTFILES/polybar" "$HOME/.config/polybar"
  symlink_dir "$DOTFILES/compton" "$HOME/.config/compton"
  symlink_dir "$DOTFILES/rofi" "$HOME/.config/rofi"
  symlink_dir "$DOTFILES/dunst" "$HOME/.config/dunst"
fi
