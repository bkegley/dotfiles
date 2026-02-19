export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
CASE_SENSITIVE="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git ssh-agent)

source $ZSH/oh-my-zsh.sh

source ~/.config/shell/init.sh
source ~/.config/shell/variables.sh
source ~/.config/shell/aliases.sh
for f in ~/.config/shell/apps/*.sh; do source "$f"; done

eval "$(starship init zsh)"

[[ -f ~/.zsh_local ]] && source ~/.zsh_local
