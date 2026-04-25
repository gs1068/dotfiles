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
   - `.claude/settings.json` と `.claude/skills/` を `~/.claude/` にリンク
   - `.codex/skills` を `~/.codex/` にリンク（Codex インストール済みの場合）
   - `.config/` 内の各ディレクトリを `~/.config/` にリンク
   - 既存ファイルがあればタイムスタンプ付きでバックアップ、既に正しいリンクならスキップ（べき等）
3. **zsh-abbr の登録** (`scripts/setup-abbr.zsh`) — zsh 利用可能な場合のみ

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
