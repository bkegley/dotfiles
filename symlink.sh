#!/bin/bash

path=$(pwd)

folders=(
	$HOME/.config
	$HOME/.config/.Xresources.d
	$HOME/.config/alacritty
	$HOME/.config/nvim
	$HOME/.config/nvim/lua
	$HOME/.config/nvim/lua/bkegley
	$HOME/.config/coc
	$HOME/.config/coc/extensions
	$HOME/.config/i3
	$HOME/.config/polybar
	$HOME/.config/polybar/scripts
	$HOME/.config/compton
	$HOME/.config/rofi
	$HOME/.config/dunst
	$HOME/themes
)

dotfiles=(
	# Xorg
	$path/.Xoverrides:$HOME/.Xresources.d/overrides
	$path/.Xresources:$HOME/.Xresources
	$path/.xinitrc:$HOME/.xinitrc

	# Bash
	$path/bash/.bashrc:$HOME/.bashrc
	$path/bash/.bash_aliases:$HOME/.bash_aliases
	$path/bash/.bash_local:$HOME/.bash_local
	$path/starship/starship.toml:$HOME/.config/starship.toml

	# Terminal
	$path/alacritty/*:$HOME/.config/alacritty/

	# Neovim
	$path/nvim/init.vim:$HOME/.config/nvim/init.vim
	$path/nvim/init.lua:$HOME/.config/nvim/init.lua
	$path/nvim/lua/bkegley/*:$HOME/.config/nvim/lua/bkegley
	$path/coc/extensions/*:$HOME/.config/coc/extensions/

	# i3
	$path/i3/*:$HOME/.config/i3/

	# Polybar
	$path/polybar/config:$HOME/.config/polybar/config
	$path/polybar/launch.sh:$HOME/.config/polybar/launch.sh
	$path/polybar/scripts/*:$HOME/.config/polybar/scripts/

	# Compton
	$path/compton/*:$HOME/.config/compton

	# Rofi
	$path/rofi/*:$HOME/.config/rofi

	# Dunst
	$path/dunst/*:$HOME/.config/dunst

	# tmux
	$path/tmux/tmux.conf:$HOME/.tmux.conf

	# Themes
	$path/themes/*:$HOME/themes/
)

for folder in ${folders[@]}; do
	[ ! -d $folder ] && mkdir -p $folder
done

for dotfile in ${dotfiles[@]}; do
    key=${dotfile%%:*}
    value=${dotfile##*:}

    [ -f $key ] && ln -sf $key $value
done
