# Setup fzf
# ---------
if [[ ! "$PATH" == *"$(brew --prefix)/opt/fzf/bin"* ]]; then
  export PATH="${PATH:+${PATH}:}$(brew --prefix)/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$(brew --prefix)/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

# Default command
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Previews
export FZF_DEFAULT_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'
