# dotfiles

shell script ベースのシンプルな dotfiles 管理。`install.sh` を実行するだけでセットアップが完了します。

## 構成

```
dotfiles/
├── install.sh           # エントリーポイント
├── scripts/
│   └── link.sh          # シンボリックリンク作成
├── home/                # ~/直下に配置するドットファイル
│   ├── .zshrc
│   ├── .bashrc
│   ├── .gitconfig
│   └── .gitignore
├── .config/             # ~/.config/ にリンクする設定群
│   ├── nvim/            # Neovim
│   ├── tmux/            # tmux
│   ├── zsh/             # zsh 関連関数
│   ├── sheldon/         # zsh プラグインマネージャー
│   ├── git/             # git グローバル ignore
│   ├── bash/            # bash 設定 (Linux)
│   ├── powershell/      # PowerShell 設定 (Windows)
│   └── scoop/           # scoop 設定 (Windows)
└── .gitignore
```

## セットアップ

### macOS / Linux

```bash
git clone git@github.com:gs1068/dotfiles.git ~/repositories/dotfiles
cd ~/repositories/dotfiles
./install.sh
```

`install.sh` は以下を行います:

- `home/` 内のドットファイルを `~/` にシンボリックリンク
- `.config/` 内の各ディレクトリを `~/.config/` にシンボリックリンク
- 既存ファイルがあればタイムスタンプ付きでバックアップ
- 既に正しいリンクが張られていればスキップ（べき等）

### Windows

Git Bash (MINGW/MSYS) で `./install.sh` を実行してください。
Windows 固有の設定（`core.autocrlf`, `ghq.root`）は自動で適用されます。

PowerShell の詳細は [Windows セットアップガイド](.config/powershell/README.md) を参照してください。

## 設定ファイルの編集

シンボリックリンクなので、リポジトリ内のファイルを編集すればそのまま反映されます。

```bash
# .zshrc を編集した場合
source ~/.zshrc

# .gitconfig, tmux, nvim などはファイル保存で即反映
```

## 主な設定内容

| ツール | 設定 |
|--------|------|
| zsh | sheldon (プラグイン管理), Powerlevel10k (テーマ), peco (履歴検索), ghq (リポジトリ管理) |
| Neovim | telescope, neo-tree, bufferline, VSCode 連携対応 |
| tmux | prefix: `C-t`, vim キーバインド, マウス有効, macOS クリップボード対応 |
| git | delta (diff), エイリアス (`g ps`, `g pl`, `g s` 等) |

## Powerlevel10k フォント

初回セットアップ時にフォントのインストールが必要です。

https://github.com/romkatv/powerlevel10k#manual-font-installation

再設定する場合:

```zsh
p10k configure
```
