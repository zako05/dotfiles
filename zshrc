# automatically enter directories without cd
setopt auto_cd

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
