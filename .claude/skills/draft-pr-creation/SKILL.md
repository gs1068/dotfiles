---
name: draft-pr-creation
description: PR を作成する際に、テンプレートがあれば必ず使用し、常にドラフト状態で作成する。
---

# Draft PR Creation

## ルール

- PR は **常にドラフト（`--draft`）** で作成する
- `--draft` が失敗した場合（無料プランのプライベートリポジトリ等）は、`--draft` なしで作成し、タイトルに `[WIP]` を付ける
- PR テンプレートが存在する場合は **必ず使用する**

## テンプレートの探索

PR 作成前に以下の順で確認し、**最初に見つかったもの**を使用する（見つかった時点で残りの探索は不要）:

1. `.github/pull_request_template.md`
2. `.github/PULL_REQUEST_TEMPLATE.md`
3. `.github/PULL_REQUEST_TEMPLATE/` ディレクトリ内のファイル
4. `docs/pull_request_template.md`

### 複数テンプレートがある場合（探索パス3）

ディレクトリ内に複数テンプレートがある場合は、変更内容から最適なテンプレートを推定し、**ユーザーに選択を確認してから**使用する。

## 作成コマンド

まず `--draft` で作成を試み、失敗したら `--draft` なしで `[WIP]` 付きタイトルにフォールバックする。

```bash
# --draft で試行
gh pr create --draft --title "..." --body "..."

# 失敗した場合のフォールバック
gh pr create --title "[WIP] ..." --body "..."
```

### テンプレートがある場合

```bash
gh pr create --draft --title "..." --body "$(cat <<'EOF'
<テンプレートに従った内容>
EOF
)"
```

### テンプレートがない場合

```bash
gh pr create --draft --title "..." --body "$(cat <<'EOF'
## Summary
...

## Test plan
...
EOF
)"
```
