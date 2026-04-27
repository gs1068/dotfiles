---
name: safe-git-workflow
description: ユーザーが明示的に指示した場合のみ git commit / push を実行する。指示があれば余計な確認を挟まず即実行する。
---

# Safe Git Workflow

## やらないこと

- ユーザーが明示的に指示するまで commit / push / force-push を実行しない
- 「変更を適用して」「修正して」等はファイル編集の許可であり、commit/push の許可ではない

## 指示されたら即実行

ユーザーが「pushして」「commitして」等と明言した場合、**余計な確認やサマリ提示を挟まず即実行する**。

- 「pushして」→ 未commitの変更があれば git add + commit + push を一気に実行する
- 「commitして」→ git add + commit を実行する（pushはしない）
- ステージングは変更ファイルを個別に `git add` する（`-A` は使わない）
- コミットメッセージは変更内容から適切に生成する（リポジトリの既存コミット形式に合わせる）
