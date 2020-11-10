#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '

source ~/.bash_aliases
source /usr/share/nvm/init-nvm.sh

eval "$(starship init bash)"
