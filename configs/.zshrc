# ====================================
# Linux-native Zsh configuration
# ====================================

# -------------------------
# Function to measure shell startup time
# -------------------------
timezsh() {
  shell=${1-$SHELL}
  for i in $(seq 1 10); do
    /usr/bin/time $shell -i -c exit
  done
}

# -------------------------
# Powerlevel10k instant prompt
# -------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -------------------------
# Local binaries
# -------------------------
local_bin=~/.local/bin
export PATH=${local_bin}:$PATH

# -------------------------
# NVM (Node Version Manager)
# -------------------------
export NVM_DIR="$HOME/.nvm"
if [ -s "$NVM_DIR/nvm.sh" ]; then
  source "$NVM_DIR/nvm.sh"
fi
if [ -s "$NVM_DIR/bash_completion" ]; then
  source "$NVM_DIR/bash_completion"
fi

# -------------------------
# Vim / Neovim aliases
# -------------------------
if command -v nvim &> /dev/null; then
  alias vim="nvim"
  alias vimdiff="nvim -d"
fi

# -------------------------
# Load Antigen + Oh-My-Zsh plugins
# -------------------------
if [ -f "${local_bin}/antigen.zsh" ]; then
  source "${local_bin}/antigen.zsh"
else
  echo "Warning: antigen.zsh not found in $local_bin"
fi

antigen use oh-my-zsh

# Core bundles
antigen bundle command-not-found
antigen bundle git
antigen bundle fzf

# Additional plugins
antigen bundle mroth/evalcache
antigen bundle lukechilds/zsh-nvm
antigen bundle zsh-users/zsh-syntax-highlighting

# Theme
antigen theme romkatv/powerlevel10k
antigen apply

# -------------------------
# zoxide (smart directory jumping)
# -------------------------
_evalcache zoxide init zsh

# Enhanced cd using zoxide fallback
function cd() {
  if [ $# -eq 0 ]; then
    builtin cd ~
  else
    z "$1" || builtin cd "$1"
  fi
}

alias ..="z .."

# -------------------------
# Fastfetch (system info)
# -------------------------
if command -v fastfetch &> /dev/null; then
  alias info="fastfetch"
  # Optional: auto-run at terminal start
  # fastfetch
fi

# -------------------------
# Common CLI tools
# -------------------------
[[ -n $(command -v fd) ]]      && alias find="fd"
[[ -n $(command -v bat) ]]     && alias cat="bat"
[[ -n $(command -v delta) ]]   && alias dif="delta -ns"
[[ -n $(command -v rg) ]]      && alias grep="rg"
[[ -n $(command -v tldr) ]]    && alias man="tldr"
[[ -n $(command -v sd) ]]      && alias seds="sd"
[[ -n $(command -v curlie) ]]  && alias http="curlie"
[[ -n $(command -v glow) ]]    && alias md="glow"
[[ -n $(command -v yazi) ]]    && alias yview="yazi"
[[ -n $(command -v dust) ]]    && alias du="dust"

# -------------------------
# FZF key bindings & completions
# -------------------------
if [ -f /usr/share/fzf/key-bindings.zsh ]; then
  source /usr/share/fzf/key-bindings.zsh
fi
if [ -f /usr/share/fzf/completion.zsh ]; then
  source /usr/share/fzf/completion.zsh
fi

# -------------------------
# Aliases & utilities
# -------------------------
alias ll="lsd -lhat"  # or 'ls -lh' if lsd not installed
alias updateAll="sudo apt update && sudo apt upgrade -y && .tmux/plugins/tpm/bin/update_plugins all && vim +PlugUpgrade +PlugUpdate +PlugInstall +PlugClean +CocInstall +CocUpdateSync +qall"
alias readerPandoc="pandoc -f html -t plain"


#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
export PATH="$HOME/Downloads/pandoc-3.7.0.2/bin:$PATH"
export PATH="$HOME/Downloads/pandoc-3.7.0.2/bin:$PATH"
export PATH=$PATH:$HOME/platform-tools
export PATH=$PATH:$HOME/Android/Sdk/platform-tools

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_com>
export PATH=$PATH:/home/shadilrayyan/Android/Sdk/platform-tools