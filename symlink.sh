path=$(pwd)

[ ! -d $HOME/.config ] && mkdir -p $HOME/.config

# ========
# Xorg
# ========
[ ! -d $HOME/.config/.Xresources.d ] && mkdir -p $HOME/.Xresources.d
ln -sf $path/.Xoverrides $HOME/.Xresources.d/overrides
ln -sf $path/.Xresources $HOME/.Xresources
ln -sf $path/.xinitrc $HOME/.xinitrc

# ========
# Git
# ========
ln -sf $path/.gitconfig $HOME/.gitconfig

# ========
# zsh
# ========
ln -sf $path/zsh/.zshrc $HOME/.zshrc
ln -sf $path/zsh/.zsh_aliases $HOME/.zsh_aliases
[ ! -d $HOME/.zsh_functions ] && mkdir -p $HOME/.zsh_functions
ln -sf $path/zsh/.zsh_functions/* $HOME/.zsh_functions/

[ -f $path/zsh/.zsh_local ] && ln -sf $path/zsh/.zsh_local $HOME/.zsh_local

# ========
# Bash
# ========
ln -sf $path/bash/.bashrc $HOME/.bashrc
ln -sf $path/bash/.bash_aliases $HOME/.bash_aliases
[ -f $path/bash/.bash_local ] && ln -sf $path/bash/.bash_local $HOME/.bash_local
ln -sf $path/starship/starship.toml $HOME/.config/starship.toml

# ========
# Terminal
# ========
[ ! -d $HOME/.config/alacritty ] && mkdir -p $HOME/.config/alacritty
ln -sf $path/alacritty/* $HOME/.config/alacritty/

# ========
# Neovim
# ========
[ ! -d $HOME/.config/nvim ] && mkdir -p $HOME/.config/nvim
ln -sf $path/nvim/init.vim $HOME/.config/nvim/init.vim
ln -sf $path/nvim/init.lua $HOME/.config/nvim/init.lua
[ ! -d $HOME/.config/nvim/lua ] && mkdir -p $HOME/.config/nvim/lua
[ ! -d $HOME/.config/nvim/lua/bkegley ] && mkdir -p $HOME/.config/nvim/lua/bkegley
ln -sf $path/nvim/lua/bkegley/* $HOME/.config/nvim/lua/bkegley

[ ! -d $HOME/.config/coc ] && mkdir -p $HOME/.config/coc
[ ! -d $HOME/.config/coc/extensions ] && mkdir -p $HOME/.config/coc/extensions
ln -sf $path/coc/extensions/* $HOME/.config/coc/extensions/

# ========
# i3
# ========
[ ! -d $HOME/.config/i3 ] && mkdir -p $HOME/.config/i3
ln -sf $path/i3/* $HOME/.config/i3/

# ========
# Polybar
# ========
[ ! -d $HOME/.config/polybar ] && mkdir -p $HOME/.config/polybar
[ ! -d $HOME/.config/polybar/scripts ] && mkdir -p $HOME/.config/polybar/scripts
ln -sf $path/polybar/config $HOME/.config/polybar/config
ln -sf $path/polybar/launch.sh $HOME/.config/polybar/launch.sh
ln -sf $path/polybar/scripts/* $HOME/.config/polybar/scripts/

# ========
# Compton
# ========
[ ! -d $HOME/.config/compton ] && mkdir -p $HOME/.config/compton
ln -sf $path/compton/* $HOME/.config/compton

# ========
# Rofi
# ========
[ ! -d $HOME/.config/rofi ] && mkdir -p $HOME/.config/rofi
ln -sf $path/rofi/* $HOME/.config/rofi

# ========
# Dunst
# ========
[ ! -d $HOME/.config/dunst ] && mkdir -p $HOME/.config/dunst
ln -sf $path/dunst/* $HOME/.config/dunst

# ========
# tmux
# ========
ln -sf $path/tmux/tmux.conf $HOME/.tmux.conf

# ========
# Karabiner Elements
# ========
[ ! -d $HOME/.config/karabiner ] && mkdir -p $HOME/.config/karabiner
ln -sf $path/karabiner/karabiner.json $HOME/.config/karabiner/karabiner.json

# ========
# Themes
# ========
[ ! -d $HOME/themes ] && mkdir -p $HOME/themes
ln -sf $path/themes/* $HOME/themes/
