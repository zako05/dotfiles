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

# Set Homebrew PATH
export PATH="/opt/homebrew/bin:$PATH"

# Load ASDF
. $(brew --prefix asdf)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# Trezor related environment variables
export HOSTNAME=`hostname`
export DISPLAY=:0

# Android SDK
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/platform-tools
# React Native - Java for Android
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
# React Native - Android Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Created by `pipx` on 2025-10-07 12:48:33
export PATH="$PATH:/Users/zako05/.local/bin"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
