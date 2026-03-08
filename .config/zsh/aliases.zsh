# zsh-abbr
source /opt/homebrew/share/zsh-abbr/zsh-abbr.zsh

# abbr でカバーできない条件付きエイリアス
if [[ $(command -v eza) ]]; then
    alias ll="eza -l -g --icons"
    alias lla="eza -l -g --icons -a"
fi
