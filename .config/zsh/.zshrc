# printf '\33c\e[3J\033[38;2;97;189;69m' #2,4,1 -> 113
# echo -e '       🭊🭂🭛'
# echo -e '      🭋🭞🭚'
# echo -e '🭇🭆🭂██🭍🬹🬹🭂██🭍🬿'
# echo -e '\033[38;2;254;186;35m🭅██████████🭟🭘' # 5,3.6,0.6 --> 221, (220, 215, 214)
# echo -e '\033[38;2;245;131;26m███████████▌' # 5,2.5,0.5 --> 215, (209, 208, 214)
# echo -e '\033[38;2;225;56;60m🭖██████████🭌🭑🬏' # 4.4,1,1 --> 185 (221)
# echo -e '\033[38;2;151;59;153m🭤🭒██████████🭝🭙' #3,1,3 --> 133
# echo -e '\033[38;2;21;159;222m 🭢🭧🭓█🭞🬎🬎🭓█🭞🭜🭗' #0.4,3,4.3 --> 38 (74, 75, 39)

printf '\33c\e[3J\033[38;5;113m' #2,4,1 -> 113
echo -e '       🭊🭂🭛'
echo -e '      🭋🭞🭚'
echo -e '🭇🭆🭂██🭍🬹🬹🭂██🭍🬿'
echo -e '\033[38;5;221m🭅██████████🭟🭘' # 5,3.6,0.6 --> 221, (220, 215, 214)
echo -e '\033[38;5;215m███████████▌' # 5,2.5,0.5 --> 215, (209, 208, 214)
echo -e '\033[38;5;203m🭖██████████🭌🭑🬏' # 4.4,1,1 --> 185 (221)
echo -e '\033[38;5;133m🭤🭒██████████🭝🭙' #3,1,3 --> 133
echo -e '\033[38;5;75m 🭢🭧🭓█🭞🬎🬎🭓█🭞🭜🭗' #0.4,3,4.3 --> 38 (74, 75, 39)

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
fi
# End

# Lines configured by zsh-newuser-install
HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=1000
SAVEHIST=1000
setopt sharehistory autocd beep extendedglob nomatch hist_expire_dups_first
bindkey -e
# End of lines configured by zsh-newuser-install

# brew installed functions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
# end

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' file-sort access
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/Users/leebyron/.zshcompletion'
# End of lines added by compinstall

# Installs "pure" prompt: https://github.com/sindresorhus/pure
fpath+=("$(brew --prefix)/share/zsh/site-functions")
# End

# zsh completion and prompt init
PURE_PROMPT_SYMBOL="🯁🯂🯃"
autoload -Uz compinit
compinit
autoload -U promptinit
promptinit
prompt pure
# End

# Suggested by http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
# See also: http://zshwiki.org/home/builtin/functions/zmv
autoload -U zmv
alias mmv='noglob zmv -W'
# End

# fnv (nvm replacement)
eval "$(fnm env --use-on-cd)"
# End

# Setup default editor
# export EDITOR=nvim
export EDITOR=zed
# End

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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}
#End

export GPG_TTY=$(tty)

# pnpm
export PNPM_HOME="/Users/leebyron/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
