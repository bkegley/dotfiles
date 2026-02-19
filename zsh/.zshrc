
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
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
   export EDITOR="zed --wait"
 fi

source ~/.zsh_aliases
[[ -f ~/.zsh_local ]] && source ~/.zsh_local

fpath+=${ZDOTDIR:-~}/.zsh_functions
path+=('/opt/homebrew/bin')
path+=$HOME/.bun/bin
export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

alias luamake=/Users/bryan/repos/git/lua-language-server/3rd/luamake/luamake

eval "$(mise activate zsh)"

# opencode
export PATH=/Users/bkegley/.opencode/bin:$PATH

# bun completions
[ -s "/Users/bkegley/.bun/_bun" ] && source "/Users/bkegley/.bun/_bun"
#compdef opencode
###-begin-opencode-completions-###
#
# yargs command completion script
#
# Installation: opencode completion >> ~/.zshrc
#    or opencode completion >> ~/.zprofile on OSX.
#
_opencode_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" opencode --get-yargs-completions "${words[@]}"))
  IFS=$si
  if [[ ${#reply} -gt 0 ]]; then
    _describe 'values' reply
  else
    _default
  fi
}
if [[ "'${zsh_eval_context[-1]}" == "loadautofunc" ]]; then
  _opencode_yargs_completions "$@"
else
  compdef _opencode_yargs_completions opencode
fi
###-end-opencode-completions-###

