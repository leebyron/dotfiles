[[ -v __ZSHENV_SOURCED ]] && return
__ZSHENV_SOURCED=1

set -a
source ~/.config/xdg.env
[ -f ~/.config/local.env ] && source ~/.config/local.env
