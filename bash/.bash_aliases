alias aliases='nvim ~/.bash_aliases'
alias src-aliases='source ~/.bash_profile && source ~/.bash_aliases'

alias cat='bat'

# search bash history with fzf
alias hist='cat ~/.bash_history | fzf | sh'


export DOTFILES_GIT_DIR=~/local/repos/personal/dotfiles
alias gitcommitdot='git --git-dir=$DOTFILES_GIT_DIR/.git/ --work-tree=$DOTFILES_GIT_DIR/ add -A
  git --git-dir=$DOTFILES_GIT_DIR/.git/ --work-tree=$DOTFILES_GIT_DIR/ commit -a'
alias gitpushdot='git --git-dir=$DOTFILES_GIT_DIR/.git/ --work-tree=$DOTFILES_GIT_DIR/ push'
  
alias v='nvim'

alias lsla='ls -la'
alias cl='clear'

# Docker
alias dc='docker-compose'

# git
alias gb='git branch'
alias gs='git status'
alias gd='git diff'
alias gc='git commit'
alias gl='git log'

# yarn
alias yw='yarn workspace'

# notifications
alias dnd-on='killall -SIGUSR1 dunst'
alias dnd-off='killall -SIGUSR2 dunst'

# recording
alias screen_lapse='ffmpeg -framerate 1 -f x11grab -s 3440,1440 -i :1 -vf settb=\(1/30\),setpts=N/TB/30 -r 30 -vcodec libx264 -crf 0 -preset ultrafast -threads 0'


