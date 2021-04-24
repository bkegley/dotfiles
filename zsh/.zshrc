
# Path to your oh-my-zsh installation.
export ZSH="/Users/bkegley/.oh-my-zsh"
export TERM='xterm-256color'

ZSH_THEME="robbyrussell"

# Use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(git ssh-agent)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi


source ~/.zsh_aliases
[[ -f ~/.zsh_local ]] && source ~/.zsh_local 

fpath+=${ZDOTDIR:-~}/.zsh_functions

eval "$(starship init zsh)"

