#!/usr/bin/env zsh
# zsh-abbr の略語を登録するスクリプト（初回 or 再セットアップ時に実行）

source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh

abbr add --force vim="nvim"
abbr add --force t="terraform"
abbr add --force g="git"
abbr add --force py="python3"
abbr add --force k="kubectl"
abbr add --force tnew="tmux new-session -s"
abbr add --force ta="tmux a"
abbr add --force tat="tmux a -t"
abbr add --force ts="tig status"
abbr add --force l="lazygit"
abbr add --force s="serpl"
abbr add --force cl="claude"
abbr add --force cld="claude --dangerously-skip-permissions"
abbr add --force cldc="claude --dangerously-skip-permissions --continue"

echo "=== abbr registered ==="
abbr list
