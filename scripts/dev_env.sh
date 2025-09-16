#!/bin/zsh

session=(dotfiles todos satoshilabs job conduit hackerrank epic js-bootcamp playwright-course)

get_session () {
  if ! tmux has-session -t "$1" 2>/dev/null; then
    echo "Session $1 does not exist."
    return 0
  else
    echo "Session $1 exists."
    return 1
  fi
}

get_repo () {
  local repo_name="$1"
  local local_dir="$2"
  local github_owner="${3:-zako05}"
  local repo_url="git@github.com:${github_owner}/${repo_name}.git"

  if [ -d "$local_dir" ]; then
    echo "Directory '$local_dir' exists. Pulling latest changes..."
    git -C "$local_dir" pull
  else 
    echo "Directory '$local_dir' does not exist. Cloning the repository..."
    git clone "$repo_url" "$local_dir"
  fi
}

workspace_exists () {
  if [ -d $WORKSPACE_DIR ]; then
    echo "Workspace direcotry exists"
  else
    echo "Workspace direcotry does not exist. Creating the directory..."
    mkdir $WORKSPACE_DIR
  fi
}

# removes the inaccessible window 0
no_window_zero () {
  sleep 1
  tmux unlink-window -k -t $1:0
}

set_session () {
  if [[ "$1" == "dotfiles" ]]; then
    local project_dir="$HOME/$1"
    get_repo "$1" "$project_dir"
    tmux new-window -t "$1:1" -n "home" -c "$HOME" -d
    tmux new-window -t "$1:2" -n "$1" -c "$project_dir" -d
      tmux split-window -t "$1" -v -c "$project_dir/scripts"
    no_window_zero "$1"
  fi

  if [[ "$1" == "todos" ]]; then
    local project_dir="$HOME/$1"
    get_repo "$1" "$project_dir"

    local current_year=$(date +%Y)
    local latest_file=$(ls -t "$project_dir"/$current_year/??????-dev.todo.md | head -n 1)

    tmux new-window -t "$1:1" -n "$1-dev" -c "$project_dir/$current_year" -d
      tmux send-keys -t "$1:1" "vim \"$latest_file\"" C-m
    tmux new-window -t "$1:2" -n "$1-sm" -c "$project_dir" -d
      tmux send-keys -t "$1:2" "vim sm.todo.md" C-m
    no_window_zero "$1"
  fi

  if [[ "$1" == "satoshilabs" ]]; then
    local project_dir="$HOME/$1"
    mkdir -p $project_dir
     
    get_repo "trezor-suite" "$project_dir/trezor-suite" "trezor"
    get_repo "trezor-user-env" "$project_dir/trezor-user-env" "trezor"

    tmux new-window -t "$1:1" -n "docs" -c "$project_dir/docs" -d
    tmux new-window -t "$1:2" -n "docs" -c "$project_dir/trezor-suite/docs" -d
    tmux new-window -t "$1:3" -n "trezor-suite" -c "$project_dir/trezor-suite/packages/suite-desktop-core" -d
      tmux split-window -t "trezor-suite" -v -c "$project_dir/trezor-suite"
      tmux send-keys -t "$1:3" "git submodule update --init --recursive && git lfs pull && yarn && yarn build:libs" C-m
      tmux split-window -t "trezor-suite" -h -c "$project_dir/trezor-suite/packages/suite-desktop-core"
    tmux new-window -t "$1:4" -n "trezor-user-env" -c "$project_dir/trezor-user-env" -d
    no_window_zero "$1"
  fi

  if [[ "$1" == "job" ]]; then
    local parent_dir="$HOME/workspace/$1"
    mkdir -p $parent_dir

    get_repo "online-cv" "$parent_dir/online-cv"
    # get_repo "vuepress-cv" "$parent_dir/vuepress-cv"

    tmux new-window -t $1:1 -n "online-cv" -c "$parent_dir/online-cv" -d
      tmux split-window -t "online-cv" -v
    # tmux new-window -t $1:2 -n "vuepress-cv" -c "$parent_dir/vuepress-cv" -d
    no_window_zero $1
  fi
  
  if [[ "$1" == "conduit" ]]; then
    local parent_dir="$HOME/workspace/project"
    local repo_name="realworld-app-conduit"
    mkdir -p $parent_dir
    get_repo "$repo_name" "$parent_dir/$repo_name"

    tmux new-window -t $1:1 -n "$1" -c "$parent_dir/$repo_name" -d
      tmux split-window -t "$1" -v
      tmux split-window -t "$1" -h
    no_window_zero $1
  fi

  if [[ "$1" == "hackerrank" ]]; then
    local parent_dir="$HOME/workspace/learn"
    local repo_name="hackerrank"
    mkdir -p $parent_dir
    get_repo "$repo_name" "$parent_dir/$repo_name"

    tmux new-window -t $1:1 -n "$1" -c "$parent_dir/$repo_name" -d
      tmux split-window -t "$1" -v
    no_window_zero $1
  fi

  if [[ "$1" == "epic" ]]; then
    local parent_dir="$HOME/workspace/learn/epic"
    mkdir -p $parent_dir
    
    get_repo "testing-javascript" "$parent_dir/testing-javascript"
    # get_repo "epic-react" "$parent_dir/epic-react"

    tmux new-window -t $1:1 -n "$1-testing" -c "$parent_dir/testing-javascript" -d
      tmux split-window -t "$1-testing" -v
      tmux split-window -t "$1-testing" -h 
    # tmux new-window -t $1:2 -n "$1-react" -c "$parent_dir/epic-react" -d
    #   tmux split-window -t "$1-react" -v
    #   tmux split-window -t "$1-react" -h
    no_window_zero $1
  fi
  
  if [[ "$1" == "js-bootcamp" ]]; then
    local parent_dir="$HOME/workspace/learn"
    mkdir -p $parent_dir
    get_repo "$1" "$parent_dir/$1"

    tmux new-window -t $1:1 -n "$1" -c "$parent_dir/$1" -d
      tmux split-window -t "$1" -v
      tmux split-window -t "$1" -h
    no_window_zero $1
  fi
 
  if [[ "$1" == "playwright-course" ]]; then
    local parent_dir="$HOME/workspace/learn"
    mkdir -p $parent_dir
   
    get_repo "provider-pw-start" "$parent_dir/provider-pw-start"
    get_repo "consumer-pw-start" "$parent_dir/consumer-pw-start"

    tmux new-window -t $1:1 -n "provider" -c "$parent_dir/provider-pw-start" -d
      tmux split-window -t "provider" -v
      tmux split-window -t "provider" -h
    tmux new-window -t $1:2 -n "consumer" -c "$parent_dir/consumer-pw-start" -d
      tmux split-window -t "consumer" -v
      tmux split-window -t "consumer" -h
    no_window_zero $1
  fi
}

tmux start-server
for s in "${session[@]}"
do
  if get_session $s; then
    # tmux new-session -d -s $s -n default -c $HOME/$s
    tmux new-session -d -s $s
    set_session $s
    echo "Session $s has been created successfully."
  fi
done
