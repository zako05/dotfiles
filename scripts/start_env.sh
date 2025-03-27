#!/bin/zsh

SESSION_ATTACHE='instea'

if [[ 'brew -v' ]]; then
  brew update && brew upgrade && brew cleanup && \
else
  echo 'Install Homebrew!'
  # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ 'vim --version' ]]; then
  vim +':PlugUpdate --sync' +qa && \
else 
  echo 'Install VIM'
fi

sh $HOME/.scripts/dev_env.sh && tmux attach -t $SESSION_ATTACHE
