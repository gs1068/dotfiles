#!/bin/bash
# 外部スキルを upstream の最新版に更新する
#
# .agents/external-skills.json に並べたスキルを、upstream の最新リリース
# （リリースがなければデフォルトブランチの最新コミット）に入れ替え、取り込んだ ref を記録する。
# GitHub Actions（.github/workflows/update-external-skills.yml）から定期実行され、差分があれば PR になる。
# 手元でも実行できる（gh CLI と jq が必要）。
#
# 更新があったスキルの一覧を Markdown で標準出力に出す（PR 本文に使う）。
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$(cd "$(dirname "$0")/.." && pwd)}"
MANIFEST="$DOTFILES_DIR/.agents/external-skills.json"
SKILLS_DIR="$DOTFILES_DIR/.agents/skills"

latest_ref() {
  local repo="$1"
  local tag
  if tag="$(gh api "repos/$repo/releases/latest" --jq .tag_name 2>/dev/null)" && [ -n "$tag" ]; then
    echo "$tag"
  else
    local branch
    branch="$(gh api "repos/$repo" --jq .default_branch)"
    gh api "repos/$repo/commits/$branch" --jq .sha
  fi
}

work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT

count="$(jq length "$MANIFEST")"
for i in $(seq 0 $((count - 1))); do
  name="$(jq -r ".[$i].name" "$MANIFEST")"
  repo="$(jq -r ".[$i].repo" "$MANIFEST")"
  path="$(jq -r ".[$i].path" "$MANIFEST")"
  current="$(jq -r ".[$i].ref" "$MANIFEST")"

  latest="$(latest_ref "$repo")"
  if [ "$current" = "$latest" ]; then
    echo "skip: $name ($current)" >&2
    continue
  fi

  src="$work/$name"
  mkdir -p "$src"
  gh api "repos/$repo/tarball/$latest" | tar -xz -C "$src" --strip-components=1
  if [ ! -f "$src/$path/SKILL.md" ]; then
    echo "error: $repo@$latest に $path/SKILL.md がありません" >&2
    exit 1
  fi

  rm -rf "${SKILLS_DIR:?}/$name"
  cp -R "$src/$path" "$SKILLS_DIR/$name"

  tmp="$(mktemp)"
  jq --indent 2 ".[$i].ref = \"$latest\"" "$MANIFEST" > "$tmp"
  mv "$tmp" "$MANIFEST"

  echo "update: $name ${current:-(未記録)} -> $latest" >&2
  if [ -n "$current" ]; then
    echo "- **$name**: [\`$current\` → \`$latest\`](https://github.com/$repo/compare/$current...$latest)"
  else
    echo "- **$name**: \`$latest\` (https://github.com/$repo)"
  fi
done
