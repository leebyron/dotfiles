# Setup fzf
# ---------
if [[ ! "$PATH" == *"${HOMEBREW_PREFIX}/opt/fzf/bin"* ]]; then
  export PATH="${PATH:+${PATH}:}${HOMEBREW_PREFIX}/opt/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOMEBREW_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOMEBREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"

# Default command
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

# Previews
export FZF_DEFAULT_OPTS='--preview "bat --color=always --style=numbers --line-range=:500 {}"'
