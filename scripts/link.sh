#!/bin/bash
# シンボリックリンクを作成する

link() {
  local src="$1"
  local dst="$2"

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    echo "skip: $dst"
    return
  fi

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
  [ "$filename" = "." ] || [ "$filename" = ".." ] && continue
  link "$file" "$HOME/$filename"
done

echo ""
echo "=== Linking .claude ==="
mkdir -p "$HOME/.claude"
link "$DOTFILES_DIR/.claude/settings.json" "$HOME/.claude/settings.json"
if [ -d "$DOTFILES_DIR/.claude/skills" ]; then
  link "$DOTFILES_DIR/.claude/skills" "$HOME/.claude/skills"
fi

echo ""
echo "=== Linking .config ==="
mkdir -p "$HOME/.config"
for dir in "$DOTFILES_DIR"/.config/*/; do
  dirname="$(basename "$dir")"
  # Alfred は同期フォルダ機能で直接参照するため、symlinkは不要
  [ "$dirname" = "Alfred.alfredpreferences" ] && continue
  link "$dir" "$HOME/.config/$dirname"
done
