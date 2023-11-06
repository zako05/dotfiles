# automatically enter directories without cd
setopt auto_cd

# autocomplition
autoload -Uz compinit && compinit

# makes color constants available
autoload -U colors
colors

# enable colored output from ls, etc. on FreeBSD-based systems
export CLICOLOR=1

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# expand functions in the prompt
setopt prompt_subst

# stop asking for confirmation for `rm *' or `rm path/*''`'`
setopt rm_star_silent         

# prompt
export PS1='[${SSH_CONNECTION+"%n@%m:"}%~] '

# ignore duplicate history entries
setopt histignoredups

# automatically pushd
setopt auto_pushd
export dirstacksize=5

# keep TONS of history
export HISTSIZE=4096

# Try not to correct command line spelling
unsetopt CORRECT_ALL

# FZF fuzzy searcher
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load ASDF
. $(brew --prefix asdf)/libexec/asdf.sh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"
