export LANG=ja_JP.UTF-8

export PATH=$PATH:/usr/local/go/bin
PATH=$PATH:$(go env GOPATH)/bin

source '/home/gs1068/.config/bash/oh-my-bash.bash'
source '/home/gs1068/.config/bash/peco.bash'

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
if command -v exa >/dev/null; then
  alias ll="exa -l -g --icons"
  alias lla="ll -a"
else
  alias ll="ls -la"
fi
