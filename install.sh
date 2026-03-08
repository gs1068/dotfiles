#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# シンボリックリンクを作成する関数
# - 既に正しいリンクが張られていればスキップ
# - 既存ファイルがあればバックアップしてからリンク作成
link() {
  local src="$1"
  local dst="$2"

  # 親ディレクトリを作成
  mkdir -p "$(dirname "$dst")"

  # 既に正しいリンクが張られていればスキップ
  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "skip: $dst"
    return
  fi

  # 既存ファイル/ディレクトリがあればバックアップ
  if [ -e "$dst" ] || [ -L "$dst" ]; then
    local backup="${dst}.bak.$(date +%Y%m%d%H%M%S)"
    echo "backup: $dst -> $backup"
    mv "$dst" "$backup"
  fi

  ln -s "$src" "$dst"
  echo "link: $src -> $dst"
}

echo "=== Linking home dotfiles ==="
for file in "$DOTFILES_DIR"/home/.*; do
  filename="$(basename "$file")"
  # . と .. をスキップ
  [ "$filename" = "." ] || [ "$filename" = ".." ] && continue
  link "$file" "$HOME/$filename"
done

echo ""
echo "=== Linking .config ==="
link "$DOTFILES_DIR/.config" "$HOME/.config"

echo ""
echo "=== Done ==="
echo "Restart your shell or run: source ~/.zshrc"
