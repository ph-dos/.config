if [[ -f "/opt/homebrew/bin/brew" ]]; then eval "$(/opt/homebrew/bin/brew shellenv)"; fi
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

autoload -U compinit && compinit
zinit cdreplay -q
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zmodload zsh/complist
_comp_options+=(globdots)

# plugins
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

zinit light Aloxaf/fzf-tab
zstyle ':fzf-tab:*' fzf-flags \
  --color=bg+:#2c2525,bg:#101010,spinner:#f38d70,fg:#e6d9db \
  --color=header:#fd6883,marker:#adda78,fg+:#f1e5e7,prompt:#f38d70 \
  --color=info:#f1e5e7,pointer:#f38d70,hl:#a6a6a6,hl+:#a6a6a6 \
  --color=border:#595959,gutter:#101010
zstyle ':fzf-tab:*' fzf-bindings 'ctrl-y:accept'
zstyle ':fzf-tab:*' accept-line ctrl-y

# completions
zinit snippet OMZP::git
zinit snippet OMZP::uv
zinit snippet OMZP::rust
# zinit snippet OMZP::docker
# zinit snippet OMZP::kubectl

source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
# source <(kubectl completion zsh)
# autoload -Uz _kubebuilder
# compdef _kubebuilder kubebuilder
[[ ! -r '/Users/ink/.opam/opam-init/init.zsh' ]] || source '/Users/ink/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null

# path
export GOPATH=$HOME/code/go
export PATH="$GOPATH/bin:$PATH"
export PATH="/Users/ink/.local/bin:$PATH"
source "$HOME/.cargo/env"

# command history
HISTSIZE=6000
SAVEHIST=6000
HISTFILE=~/.cache/zsh/.zsh_history
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups

# keybinds
bindkey '^f' forward-word
bindkey '^b' backward-word
bindkey '^y' autosuggest-accept

# alias
alias vi='nvim'
alias ls='eza -1 --icons --group-directories-first'
alias ta='tmux attach'
alias fd='find'
alias claw='claude'
# alias k8s='kubectl'
# alias dockerd='colima start'

# envvars
source ~/.env.local
export FZF_DEFAULT_OPTS="
  --color=bg+:#2c2525,bg:#101010,spinner:#f38d70,fg:#e6d9db
  --color=header:#fd6883,marker:#adda78,fg+:#f1e5e7,prompt:#f38d70
  --color=info:#f1e5e7,pointer:#f38d70,hl:#a6a6a6,hl+:#a6a6a6
  --color=border:#595959,gutter:#101010,query:#e6d9db"
