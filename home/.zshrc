source ~/.config/zsh/path.zsh
source ~/.config/zsh/env.zsh

eval "$(sheldon source)"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"

source ~/.config/zsh/peco.zsh
source ~/.config/zsh/ghq.zsh
source ~/.config/zsh/p10k.zsh
source ~/.config/zsh/startuptime.zsh

# コマンドのスペルを訂正
setopt correct
# 小文字でも大文字ディレクトリ、ファイルを補完できるようにする
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

source ~/.config/zsh/aliases.zsh
