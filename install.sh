#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Installing dependencies ==="
source "$DOTFILES_DIR/scripts/deps.sh"

echo ""
source "$DOTFILES_DIR/scripts/link.sh"

# zsh-abbr のセットアップ（zshが利用可能な場合）
if command -v zsh &>/dev/null; then
  echo ""
  echo "=== Setting up zsh-abbr ==="
  zsh "$DOTFILES_DIR/scripts/setup-abbr.zsh"
else
  echo ""
  echo "=== Skipping zsh-abbr (zsh not found) ==="
fi

# Windows の場合、gitconfig を動的に設定
if [[ "$(uname -s)" == MINGW* ]] || [[ "$(uname -s)" == MSYS* ]]; then
  echo ""
  echo "=== Windows specific settings ==="
  git config --global core.autocrlf input
  git config --global ghq.root "C:/Users/$(whoami)/repositories"
  echo "set: core.autocrlf = input"
  echo "set: ghq.root = C:/Users/$(whoami)/repositories"
fi

echo ""
echo "=== Done ==="
echo "Restart your shell or run: source ~/.zshrc"
