#!/bin/zsh

SESSION_ATTACHE='todos'

update_brew_vim () {
  if brew -v &> /dev/null; then
    brew cleanup && brew upgrade && brew update && \
  else
    echo 'Homebrew not found. Skipping update.'
    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  
  if vim --version &> /dev/null; then
    vim +':PlugUpdate --sync' +qa && \
  else 
    echo 'Vim not found. Skipping plugin update.'
  fi
}

show_help () {
  local script_name="start_env.sh"
  echo "Usage: $(basename "$script_name") [options]"
  echo ""
  echo "This script updates Homebrew and Vim, then attaches to a tmux session."
  echo ""
  echo "Options:"
  echo "  -u, --update      Performs updates for Homebrew and Vim only."
  echo "  -h, --help        Show this help message."
  echo ""
  echo "Examples:"
  echo "  $(basename "$script_name")"
  echo "    Runs updates and attaches to the tmux session."
  echo ""
  echo "  $(basename "$script_name") --update"
  echo "    Runs updates only."
}

if [[ "$1" == "-u" || "$1" == "--update" ]]; then
  update_brew_vim
elif [[ "$1" == "-h" || "$1" == "--help" ]]; then
  show_help
else
  update_brew_vim
  sh "$HOME/scripts/dev_env.sh" && tmux attach -t "$SESSION_ATTACHE"
fi
