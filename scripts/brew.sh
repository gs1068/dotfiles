#!/bin/bash

# Homebrew のインストール
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Brewfile からパッケージをインストール
brew bundle --file="$HOME/.Brewfile"
