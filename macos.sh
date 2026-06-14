#!/usr/bin/env zsh
set -euo pipefail

if (( $+commands[brew] )); then
    brew update
else
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if (( $+commands[rustup] )); then
    rustup self update || true
    rustup update
else
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
fi

[[ -f "$HOME/.cargo/env" ]] && source "$HOME/.cargo/env"

brew --version
rustup --version
cargo --version

brew trust nikitabobko/tap
brew bundle --file="$HOME/.config/Brewfile"
