# Path extensions
eval `/usr/libexec/path_helper -s`
export PATH="$(brew --prefix)/bin:${PATH}"
export PATH="$(brew --prefix ruby)/bin:$PATH"
export PATH="$(brew --prefix postgresql@11)/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Users/leebyron/.cargo/bin:$PATH"
# End

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch
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
export EDITOR=nvim
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
alias dot='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
# End

# Search history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
# End

# pyenv (adds 250ms)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv init --path)"
#End

# added by travis gem
[ -f /Users/leebyron/.travis/travis.sh ] && source /Users/leebyron/.travis/travis.sh
# End
export PATH="/usr/local/opt/bison/bin:$PATH"

# Setting hub as the git wrapper (adds 30ms)
eval "$(hub alias -s)"
export PATH="$(brew --prefix)/opt/avr-gcc@8/bin:$PATH"
#End

# added by fzf installer (adds 50ms)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#End

# ghg specific setup
if [ -f "$HOME/Code/ghg" ]; then
  # ghg script completions
  source "$HOME/Code/ghg/scripts/completions.sh"

  #gcloud
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc"
  source "$(brew --prefix)/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc"

  #Watershed user
  export WS_USER=lee
  export LINT_ON_COMMIT=true
fi
#End

export GPG_TTY=$(tty)

# pnpm
export PNPM_HOME="/Users/leebyron/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


echo "       🭊🭂🭛"
echo "      🭋🭞🭚"
echo "🭇🭆🭂██🭍🬹🬹🭂██🭍🬿"
echo "🭅██████████🭟🭘"
echo "███████████▌"
echo "🭖██████████🭌🭑🬏"
echo "🭤🭒██████████🭝🭙"
echo " 🭢🭧🭓█🭞🬎🬎🭓█🭞🭜🭗"
