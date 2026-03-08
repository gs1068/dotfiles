# PATH
if [[ "$(uname)" == "Darwin" ]]; then
  export PATH=/opt/homebrew/bin:$PATH
  export PATH="/opt/homebrew/sbin:$PATH"
  export PATH="$HOME/Library/Python/3.9/bin:$PATH"
fi
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

eval "$(sheldon source)"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"

# functions
source ~/.config/zsh/peco.zsh
source ~/.config/zsh/ghq.zsh
source ~/.config/zsh/p10k.zsh
source ~/.config/zsh/startuptime.zsh

# Go
if command -v go &>/dev/null; then
  export GOROOT=$(go env GOROOT)
  export PATH=$GOROOT/bin:$PATH
fi

# コマンドのスペルを訂正
setopt correct
# 小文字でも大文字ディレクトリ、ファイルを補完できるようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Alias
alias vim="nvim"
alias t="terraform"
alias g="git"
alias py="python3"
alias k="kubectl"
alias tnew="tmux new-session -s"
alias ta="tmux a"
alias tat="tmux a -t"
alias ts="tig status"
alias l="lazygit"
alias s="serpl"
if [[ $(command -v eza) ]]; then
    alias ll="eza -l -g --icons"
    alias lla="ll -a"
fi
