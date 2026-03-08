# options
# auto_list: 自動リストはBashではデフォルトで無効
# share_factory: 相当するオプションはなし
# hist_ignore_all_dups: 重複する履歴を無視
HISTCONTROL=ignoredups:erasedups

# history
HISTFILE=$HOME/.bash_history
HISTSIZE=100000
HISTFILESIZE=1000000

# 過去に実行したコマンドを選択。Ctrl-rにバインド
peco-select-history() {
  local lbuffer
  lbuffer="${READLINE_LINE:0:$READLINE_POINT}"
  # タイムスタンプを含むすべての前置きを除去してから peco に渡す
  READLINE_LINE=$(history | sed 's/^[ ]*[0-9]*[ ]*[0-9]*-[0-9]*-[0-9]* [0-9]*:[0-9]*:[0-9]* //' | tac | peco --query "$lbuffer")
  READLINE_POINT=${#READLINE_LINE}
}

bind -x '"\C-r": peco-select-history'
