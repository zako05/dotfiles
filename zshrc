# Automatically enter directories without cd
setopt auto_cd

# Autocomplition
autoload -Uz compinit && compinit

# Makes color constants available
autoload -U colors
colors

# Enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# Aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# Toggle proxy
if [ -e "$HOME/.scripts/proxy.zsh" ]; then
  source "$HOME/.scripts/proxy.zsh"
fi

# Expand functions in the prompt
setopt prompt_subst

# Stop asking for confirmation for `rm *' or `rm path/*''`'`
setopt rm_star_silent         

# Prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# Ignore duplicate history entries
setopt histignoredups

# Automatically pushd
setopt auto_pushd
export dirstacksize=5

# Keep TONS of history
export HISTSIZE=4096

# Force Emacs mode for native line/word navigation
bindkey -e

# Map Ctrl+h/j/k/l to move left/down/up/right (arrow keys) in shell prompt
bindkey '^H' backward-char
bindkey '^L' forward-char
bindkey '^J' down-line-or-history
bindkey '^K' up-line-or-history

# Custom escape sequence for Cmd+L to clear screen (sent by Ghostty)
bindkey '\x1e' clear-screen

# Try not to correct command line spelling
unsetopt CORRECT_ALL

# FZF fuzzy searcher
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Deduplicate PATH entries
typeset -U path PATH

# Load ASDF
. $(brew --prefix asdf)

# Load NVM
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# PATH additions (Homebrew is set in ~/.zprofile)
export PATH="$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools:$HOME/.local/bin"
