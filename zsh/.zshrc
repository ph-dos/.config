# zinit set up
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# suggestions
zinit snippet OMZP::rust
zinit snippet OMZP::uv
zinit snippet OMZP::git

# optional
# zinit snippet OMZP::docker
# zinit snippet OMZP::kubectl

# zsh native stuff
HISTSIZE=2000
SAVEHIST=2000
HISTDUP=erase
HISTFILE=~/.cache/zsh/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

autoload -U compinit && compinit
zinit cdreplay -q
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# alias
alias vi='nvim'
alias ls='eza --icons -lh && echo ""'
alias ta='tmux attach'
alias fd='find'

# optional
# alias k8s='kubectl'
# alias dockerd='colima start'

# keybinds
bindkey '^y' autosuggest-accept
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# source & imports
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
fpath=(~/.config/zsh/completion $fpath)
export GOPATH="$HOME/code/go"

# optional
# source <(kubectl completion zsh)
# autoload -Uz _kubebuilder
# compdef _kubebuilder kubebuilder
# export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
