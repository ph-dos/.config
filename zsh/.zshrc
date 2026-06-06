# zinit set up
if [[ -f "/opt/homebrew/bin/brew" ]]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi
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
zinit snippet OMZP::git
zinit snippet OMZP::uv
zinit snippet OMZP::gcloud
# zinit snippet OMZP::docker
# zinit snippet OMZP::kubectl
# zinit snippet OMZP::rust

# command history
HISTSIZE=6000
SAVEHIST=6000
HISTFILE=~/.cache/zsh/.zsh_history
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups

autoload -U compinit && compinit
zinit cdreplay -q
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
compinit
_comp_options+=(globdots)

# alias
alias vi='nvim'
alias ls='eza --icons -lh'
alias ta='tmux attach'
alias fd='find'

# optional
# alias k8s='kubectl'
# alias dockerd='colima start'
alias claw='claude --permission-mode plan'

# CL keybinds
bindkey '^y' autosuggest-accept
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# shell
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
fpath=(~/.config/zsh/completion $fpath)

# source <(kubectl completion zsh)
# autoload -Uz _kubebuilder
# compdef _kubebuilder kubebuilder
# export PATH="/opt/homebrew/opt/postgresql@18/bin:$PATH"
[[ ! -r '/Users/ink/.opam/opam-init/init.zsh' ]] || source '/Users/ink/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
export GOPATH=$HOME/code/go
export PATH="$PATH:$(go env GOPATH)/bin"

# local config
source ~/.env.local
