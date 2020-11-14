#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

export EDITOR=nvim

source ~/.bash_aliases
[[ -f ~/.bash_local ]] && source ~/.bash_local 

[[ -f /usr/share/nvm/init-nvm.sh ]] && source /usr/share/nvm/init-nvm.sh

eval "$(starship init bash)"
