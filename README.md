# dotfiles

shell script ベースのシンプルな dotfiles 管理。`install.sh` を実行するだけでセットアップが完了します。

## セットアップ

### macOS / Linux

```bash
git clone git@github.com:gs1068/dotfiles.git ~/repositories/dotfiles
cd ~/repositories/dotfiles
./install.sh
```

`install.sh` は以下を行います:

1. **依存パッケージのインストール** (`scripts/deps.sh`) — Homebrew, Brewfile, oh-my-bash
2. **シンボリックリンクの作成** (`scripts/link.sh`):
   - `home/` 内のドットファイルを `~/` にリンク
   - `.claude/skills/` を `~/.claude/` にリンク
   - `.claude/settings.json` を `~/.claude/settings.json` にマージ（`scripts/claude-settings.sh`、下記参照）
   - `.codex/skills` を `~/.codex/` にリンク（Codex インストール済みの場合）
   - `.config/` 内の各ディレクトリを `~/.config/` にリンク
   - 既存ファイルがあればタイムスタンプ付きでバックアップ、既に正しいリンクならスキップ（べき等）
3. **zsh-abbr の登録** (`scripts/setup-abbr.zsh`) — zsh 利用可能な場合のみ

### Claude Code の settings.json

`~/.claude/settings.json` は Claude Code や Orca などのツールが書き換えるため、symlink ではなく実ファイルとして置きます。
dotfiles の `.claude/settings.json` には、どのマシンでも使う共通設定だけを書きます。

```bash
scripts/claude-settings.sh apply  # 共通設定を ~/.claude/settings.json にマージ
scripts/claude-settings.sh diff   # 共通設定との差分と、ローカルにしかないキーを表示
```

- 値が衝突したら dotfiles 側を優先し、配列（`permissions.allow`、`hooks` など）は和集合をとる
- dotfiles 側にないキー（ツールが追加した設定や、会社固有の `autoMode` など）はローカルに残る
- dotfiles から消したキーはローカルからは消えないので、必要なら手で消す
- ローカルで変えた設定を他のマシンにも配りたいときは、`diff` で確認して dotfiles 側に書き写す

### 外部スキル

`.agents/skills/` には、自作スキルのほかに外部リポジトリのスキルも commit して置いています（Claude Code と Codex の両方から使うため）。
外部スキルは `.agents/external-skills.json` に upstream と取り込んだ ref を登録します。

- GitHub Actions（`.github/workflows/update-external-skills.yml`）が毎週 upstream の最新リリースを確認し、更新があれば PR を作る
- 手動で更新するときは `scripts/update-external-skills.sh`（`gh` と `jq` が必要）
- 新しく追加するときは `external-skills.json` に `name`・`repo`・`path`（upstream 内の SKILL.md があるディレクトリ）を書き、`ref` を空にしてスクリプトを実行する

### Windows

Git Bash (MINGW/MSYS) で `./install.sh` を実行してください。
Windows 固有の設定（`core.autocrlf`, `ghq.root`）は自動で適用されます。

PowerShell の詳細は [Windows セットアップガイド](.config/powershell/README.md) を参照してください。

## Powerlevel10k フォント

初回セットアップ時にフォントのインストールが必要です。

https://github.com/romkatv/powerlevel10k#manual-font-installation

再設定する場合:

```zsh
p10k configure
```
