case $- in
*i*) ;;
*) return ;;
esac

OSH_THEME="agnoster"
DEFAULT_USER=$(whoami)

OMB_USE_SUDO=true

completions=(
  git
  composer
  ssh
)

aliases=(
  general
)

plugins=(
  git
  bashmarks
)

export OSH=~/.oh-my-bash
source "$OSH"/oh-my-bash.sh
