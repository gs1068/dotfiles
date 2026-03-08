if [[ "$(uname)" == "Darwin" ]]; then
  export PATH=/opt/homebrew/bin:$PATH
  export PATH="/opt/homebrew/sbin:$PATH"
  export PATH="$HOME/Library/Python/3.9/bin:$PATH"
fi
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Go
if command -v go &>/dev/null; then
  export GOROOT=$(go env GOROOT)
  export PATH=$GOROOT/bin:$PATH
fi
