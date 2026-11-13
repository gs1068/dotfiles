#!/bin/bash
# ~/.claude/settings.json を dotfiles の共通設定と同期する
#
# ~/.claude/settings.json は Claude Code や Orca などのツールが書き換えるため、
# symlink にせず実ファイルとして置き、dotfiles 側の共通設定をマージする。
#
#   apply : 共通設定を ~/.claude/settings.json にマージする（install.sh から呼ばれる）
#           - オブジェクトは再帰的にマージ、値の衝突は dotfiles 側を優先
#           - 配列（permissions.allow や hooks など）は和集合をとる
#           - dotfiles 側にないキー（ツールが追加した設定）はそのまま残す
#   diff  : 共通設定との差分と、ローカルにしかないキーを表示する
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
BASE="$DOTFILES_DIR/.claude/settings.json"
LOCAL="$HOME/.claude/settings.json"

MERGE_JQ='
def merge($a; $b):
  if ($a | type) == "object" and ($b | type) == "object" then
    reduce (($a + $b) | keys_unsorted[]) as $k ({};
      .[$k] = (if ($a | has($k)) and ($b | has($k)) then merge($a[$k]; $b[$k])
               elif ($b | has($k)) then $b[$k]
               else $a[$k] end))
  elif ($a | type) == "array" and ($b | type) == "array" then
    reduce $b[] as $x ($a; if any(.[]; . == $x) then . else . + [$x] end)
  else $b end;
merge(.[0]; .[1])
'

apply() {
  mkdir -p "$(dirname "$LOCAL")"

  # 旧構成（symlink）からの移行: 中身を保ったまま実ファイルに置き換える
  if [ -L "$LOCAL" ]; then
    local tmp
    tmp="$(mktemp)"
    cp "$LOCAL" "$tmp"
    rm "$LOCAL"
    mv "$tmp" "$LOCAL"
    echo "unlink: $LOCAL (symlink -> 実ファイル)"
  fi

  if [ ! -e "$LOCAL" ]; then
    cp "$BASE" "$LOCAL"
    echo "copy: $BASE -> $LOCAL"
    return
  fi

  if ! command -v jq &>/dev/null; then
    echo "skip: jq がないため $LOCAL へのマージをスキップ"
    return
  fi

  local merged
  merged="$(jq -s "$MERGE_JQ" "$LOCAL" "$BASE")"
  if [ "$(jq -S . "$LOCAL")" = "$(echo "$merged" | jq -S .)" ]; then
    echo "skip: $LOCAL"
    return
  fi

  local backup="${LOCAL}.bak.$(date +%Y%m%d%H%M%S)"
  cp "$LOCAL" "$backup"
  echo "$merged" > "$LOCAL"
  echo "merge: $BASE -> $LOCAL (backup: $backup)"
}

show_diff() {
  echo "=== dotfiles にあるキーの差分 (- dotfiles / + local) ==="
  diff -u \
    --label dotfiles <(jq -S . "$BASE") \
    --label local <(jq -S --slurpfile b "$BASE" 'with_entries(select(.key as $k | $b[0] | has($k)))' "$LOCAL") \
    | cut -c1-160 || true
  echo ""
  echo "=== local にしかないキー ==="
  jq -r --slurpfile b "$BASE" 'keys_unsorted[] | select(. as $k | $b[0] | has($k) | not)' "$LOCAL"
}

case "${1:-}" in
  apply) apply ;;
  diff) show_diff ;;
  *)
    echo "usage: $0 {apply|diff}" >&2
    exit 1
    ;;
esac
