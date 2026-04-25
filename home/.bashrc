export LANG=ja_JP.UTF-8

export PATH=$PATH:/usr/local/go/bin
if command -v go &>/dev/null; then
  PATH=$PATH:$(go env GOPATH)/bin
fi

source "$HOME/.config/bash/oh-my-bash.bash"
source "$HOME/.config/bash/peco.bash"

# direnv
eval "$(direnv hook bash)"

# コマンドのスペルを訂正
shopt -s cdspell

# 小文字でも大文字ディレクトリ、ファイルを補完できるようにする
bind 'set completion-ignore-case on'

# Alias
alias vim="nvim"
alias g="git"
alias py="python3"
alias k="kubectl"
alias tnew="tmux new-session -s"
alias ta="tmux a -t"
alias ts="tig status"
if command -v eza &>/dev/null; then
  alias ll="eza -l -g --icons"
  alias lla="eza -l -g --icons -a"
else
  alias ll="ls -la"
  alias lla="ls -la"
fi
