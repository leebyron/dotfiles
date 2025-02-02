# printf '\33c\e[3J\033[38;5;113m' #2,4,1 -> 113
# echo -e '       🭊🭂🭛'
# echo -e '      🭋🭞🭚'
# echo -e '🭇🭆🭂██🭍🬹🬹🭂██🭍🬿'
# echo -e '\033[38;5;221m🭅██████████🭟🭘' # 5,3.6,0.6 --> 221, (220, 215, 214)
# echo -e '\033[38;5;215m███████████▌' # 5,2.5,0.5 --> 215, (209, 208, 214)
# echo -e '\033[38;5;203m🭖██████████🭌🭑🬏' # 4.4,1,1 --> 185 (221)
# echo -e '\033[38;5;133m🭤🭒██████████🭝🭙' #3,1,3 --> 133
# echo -e '\033[38;5;75m 🭢🭧🭓█🭞🬎🬎🭓█🭞🭜🭗' #0.4,3,4.3 --> 38 (74, 75, 39)

# Pure prompt init
PURE_PROMPT_SYMBOL="🯁🯂🯃"
autoload -U promptinit
promptinit
prompt pure

# fzf init
source <(fzf --zsh)

# History config
SAVEHIST=2000
HISTSIZE=2000
HISTFILE="$XDG_STATE_HOME/zsh_history"
setopt sharehistory autocd beep extendedglob nomatch hist_expire_dups_first
bindkey -e

[ -d "$XDG_CACHE_HOME"/zsh ] || mkdir -p "$XDG_CACHE_HOME"/zsh
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompcache"
# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' file-sort access
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename "$XDG_CONFIG_HOME/zsh/.zshrc"
# End of lines added by compinstall
autoload -Uz compinit
# Cache the initialization here. -C requires removing this file to clear cache
compinit -C -d "$XDG_CACHE_HOME/zsh/zcompdump-$ZSH_VERSION"

# Ghostty shell integration
if [[ -n $GHOSTTY_RESOURCES_DIR ]]; then
  source "$GHOSTTY_RESOURCES_DIR"/shell-integration/zsh/ghostty-integration
fi

# Path extensions
if [ -z "$NIX_PATH" ]; then
  eval `/usr/libexec/path_helper -s`
  export PATH="$(brew --prefix)/bin:${PATH}"
  export PATH="$(brew --prefix ruby)/bin:$PATH"
  export PATH="$(brew --prefix postgresql@11)/bin:$PATH"
  export PATH="$HOME/.local/bin:$PATH"
  export PATH="/Users/leebyron/.cargo/bin:$PATH"
  # If this is a brew install of zsh
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
  fpath+=("$(brew --prefix)/share/zsh/site-functions")
fi
# End

# Suggested by http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
# See also: http://zshwiki.org/home/builtin/functions/zmv
autoload -U zmv
alias mmv='noglob zmv -W'
# End

# fnm (nvm replacement)
if [ command -v fnm >/dev/null 2>&1 ]; then
  eval "$(fnm env --use-on-cd)"
fi

# Setup default editor
export EDITOR=zed

# Configure ls to use color and set up common aliases
export CLICOLOR=1
export LSCOLORS=GxFxCxDxBxegedabagaced
alias l='ls -aF'
alias ll='ls -aFgho'
# End

# Configure common aliases for git
alias gs='git addremove; git status'
# End

# Git & Homebrew dotfiles
export HOMEBREW_BREWFILE=~/.Brewfile
alias dot='git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
# End

# Search history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
# End

# pyenv (adds 250ms)
if [ command -v pyenv >/dev/null 2>&1 ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init -)"
  eval "$(pyenv init --path)"
fi
#End

# added by travis gem
[ -f /Users/leebyron/.travis/travis.sh ] && source /Users/leebyron/.travis/travis.sh
# End
export PATH="/usr/local/opt/bison/bin:$PATH"

# Setting hub as the git wrapper (adds 30ms)
if [ command -v hub >/dev/null 2>&1 ]; then
  eval "$(hub alias -s)"
  export PATH="$(brew --prefix)/opt/avr-gcc@8/bin:$PATH"
fi
#End

# added by fzf installer (adds 50ms)
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# _fzf_compgen_path() {
#   fd --hidden --exclude .git . "$1"
# }
# _fzf_compgen_dir() {
#   fd --type=d --hidden --exclude .git . "$1"
# }
#End

export GPG_TTY=$(tty)

# pnpm
export PNPM_HOME="/Users/leebyron/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
