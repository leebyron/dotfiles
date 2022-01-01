# Path extensions
eval `/usr/libexec/path_helper -s`
export PATH="/Users/leebyron/.cargo/bin:$PATH"
# End

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd beep extendedglob nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' file-sort access
zstyle ':completion:*' squeeze-slashes true
zstyle :compinstall filename '/Users/leebyron/.zshcompletion'
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Suggested by http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
# See also: http://zshwiki.org/home/builtin/functions/zmv
autoload -U zmv
alias mmv='noglob zmv -W'
# End

# Added by nvm installer
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# End

# Installs "pure" prompt: https://github.com/sindresorhus/pure
autoload -U promptinit; promptinit
prompt pure
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

# Git dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.config/dotfiles/ --work-tree=$HOME'
# End

# Search history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
# End

# added by travis gem
[ -f /Users/leebyron/.travis/travis.sh ] && source /Users/leebyron/.travis/travis.sh
# End
export PATH="/usr/local/opt/bison/bin:$PATH"

# Setting hub as the git wrapper
eval "$(hub alias -s)"
export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"

# added by fzf installer
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
