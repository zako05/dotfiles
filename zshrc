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

# Try not to correct command line spelling
unsetopt CORRECT_ALL

# FZF fuzzy searcher
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load ASDF
. $(brew --prefix asdf)

export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm

export PATH="/usr/bin:$PATH"
export PATH="/usr/sbin:$PATH"
