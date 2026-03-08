export PATH=/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/sbin:$PATH"
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

eval "$(sheldon source)"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)" # for circus

########function##########
source ~/.config/zsh/peco.zsh
source ~/.config/zsh/ghq.zsh
source ~/.config/zsh/p10k.zsh
source ~/.config/zsh/startuptime.zsh
########function##########

export GOROOT=$(go1.24.3 env GOROOT)
export PATH=$GOROOT/bin:$PATH

# CIRCUS_BACKEND_V2_PAT は .envrc や 1password CLI 等で管理してください

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
alias c="chezmoi"
alias s=" serpl"
alias t="terraform"
if [[ $(command -v eza) ]]; then
    alias ll="eza -l -g --icons"
    alias lla="ll -a"
fi
