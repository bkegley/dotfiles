# Add deno completions to search path
if [[ ":$FPATH:" != *":/Users/bkegley/.zsh/completions:"* ]]; then export FPATH="/Users/bkegley/.zsh/completions:$FPATH"; fi

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

plugins=(git ssh-agent asdf)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='vim'
 else
   export EDITOR='nvim'
 fi

export GIT_EDITOR=nvim

export NVM_DIR="$HOME/.nvm"
#This loads nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
#This loads nvm bash_completion
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

source ~/.zsh_aliases

export NVIM_APPNAME=nvim-lazy
vv() {
  # Assumes all configs exist in directories named ~/.config/nvim-*
  local config=$(fd --max-depth 1 --glob 'nvim-*' ~/.config | fzf --prompt="Neovim Configs > " --height=~50% --layout=reverse --border --exit-0)

  # If I exit fzf without selecting a config, don't open Neovim
  [[ -z $config ]] && echo "No config selected" && return

  # Open Neovim with the selected config
  NVIM_APPNAME=$(basename $config) nvim $@
}

fpath+=${ZDOTDIR:-~}/.zsh_functions
path+=('/opt/homebrew/bin')


export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

eval "$(starship init zsh)"

# Make Node recognize the mkcert root CA
export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"


autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

alias luamake=/Users/bryan/repos/git/lua-language-server/3rd/luamake/luamake

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# opencode
export PATH=/Users/bkegley/.opencode/bin:$PATH

# Added by Antigravity
export PATH="/Users/bkegley/.antigravity/antigravity/bin:$PATH"

eval "$(mise activate zsh)"
. "/Users/bkegley/.deno/env"

# Vite+ bin (https://viteplus.dev)
. "$HOME/.vite-plus/env"

[[ -f ~/.zsh_local ]] && source ~/.zsh_local
