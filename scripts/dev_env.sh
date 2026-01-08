#!/bin/zsh

# Configuration variables
readonly SESSION=(dotfiles todos satoshilabs job articles conduit hackerrank epic js-bootcamp playwright-course)
readonly ATTACH_SESSION="satoshilabs"
readonly DEFAULT_GITHUB_USER="zako05"

# --- Helper Functions ---

has_session () {
  tmux has-session -t "$1" &> /dev/null
}

new_window () {
  local session_name="$1"
  local window_index="$2"
  local window_name="$3"
  local window_path="$4"

  tmux new-window -t "${session_name}:${window_index}" -n "${window_name}" -c "${window_path}" -d
}

# Clones or pulls a git repository.
# Arguments: repo_name, local_dir, [github_owner]
get_repo () {
  local repo_name="$1"
  local local_dir="$2"
  local github_owner="${3:-$DEFAULT_GITHUB_USER}"
  local repo_url="git@github.com:${github_owner}/${repo_name}.git"

  if [ -d "$local_dir" ]; then
    echo "Directory '$local_dir' exists. Pulling latest changes..."
    git -C "$local_dir" pull
  else 
    echo "Directory '$local_dir' does not exist. Cloning the repository..."
    git clone "$repo_url" "$local_dir"
  fi
}

# --- Session Management ---

# Sets up a specific tmux session based on its name.
set_session () {
  local session_name="$1"
  local project_dir
  local parent_dir
  local repo_name

  case "$session_name" in
    "dotfiles")
      project_dir="$HOME/$session_name"
      get_repo "$session_name" "$project_dir"

      new_window "$session_name" 1 "home" "$HOME"
      new_window "$session_name" 2 "$session_name" "$project_dir"
      tmux split-window -t "$1" -v -c "$project_dir/scripts"
      ;;

    "todos")
      project_dir="$HOME/$session_name"
      get_repo "$session_name" "$project_dir"

      local current_year=$(date +%Y)
      local year_dir="$project_dir/$current_year"

      # Create the year directory if it doesn't exist (e.g., first run in 2026)
      if [[ ! -d "$year_dir" ]]; then
        echo "Creating new directory for $current_year..."
        mkdir -p "$year_dir"
      fi

      local latest_file=($year_dir/??????-dev.todo.md(Nom[1]))

      # If no file exists for this year yet, generate the new on
      if [[ -z "$latest_file" ]]; then
        local year_month=$(date +%Y%m)
        
        echo "Creating new file $year_dir/$year_month"

        latest_file="$year_dir/$year_month-dev.todo.md"
        touch $latest_file
      fi

      new_window $session_name 1 "$session_name-dev" "$year_dir"
      [[ -n "$latest_file" ]] && tmux send-keys -t "$session_name:1" "vim \"$latest_file\"" C-m
      new_window $session_name 2 "$session_name-sm" "$project_dir"
      tmux send-keys -t "$1:2" "vim sm.todo.md" C-m
      tmux select-window -t "$session_name:1"
      ;;
    
    "satoshilabs")
      project_dir="$HOME/$session_name"
      mkdir -p "$project_dir"
      get_repo "trezor-suite" "$project_dir/trezor-suite" "trezor"
      get_repo "trezor-user-env" "$project_dir/trezor-user-env" "trezor"

      new_window "$session_name" 1 "my-docs" "$project_dir/docs"
      tmux split-window -t "$session_name:1" -h -c "$project_dir/tmp/screencast"
      tmux select-pane -t "$session_name:1.1"
      tmux split-window -t "$session_name:1" -v -c "$project_dir/tmp"
      new_window "$session_name" 2 "e2e-docs" "$project_dir/trezor-suite/suite/e2e/docs"
      new_window "$session_name" 3 "trezor-suite" "$project_dir/trezor-suite"
      tmux split-window -t "$session_name:3" -v -c "$project_dir/trezor-suite"
      tmux select-pane -t "$session_name:3.1"
      tmux split-window -t "$session_name:3" -h -c "$project_dir/trezor-suite/suite/e2e"
      tmux select-pane -t "$session_name:3.3"
      tmux split-window -t "$session_name:3" -h -c "$project_dir/trezor-suite"
      tmux send-keys -t "$session_name:3.3" "git submodule update --init --recursive && git lfs pull && yarn && yarn build:libs && yarn suite:dev" C-m
      new_window "$session_name" 4 "trezor-user-env" "$project_dir/trezor-user-env"
      tmux split-window -t "$session_name:4" -h -c "$project_dir/trezor-suite/packages/trezor-user-env-link"
      tmux send-keys -t "$session_name:4.1" "./run.sh" C-m
      tmux send-keys -t "$session_name:4.2" "vim src/api.ts" C-m
      new_window "$session_name" 5 "suite-native-android" "$project_dir/trezor-suite/suite-native/app"
      tmux split-window -t "$session_name:5" -v -c "$project_dir/trezor-suite/suite-native/app"
      tmux select-pane -t "$session_name:5.1"
      tmux split-window -t "$session_name:5" -h -c "$project_dir/trezor-suite/suite-native/app/e2e"
      tmux select-pane -t "$session_name:5.3"
      tmux split-window -t "$session_name:5" -h -c "$project_dir/trezor-suite/suite-native/app"
      new_window "$session_name" 6 "suite-native-ios" "$project_dir/trezor-suite/suite-native/app"
      tmux split-window -t "$session_name:6" -v -c "$project_dir/trezor-suite/suite-native/app"
      tmux select-pane -t "$session_name:6.1"
      tmux split-window -t "$session_name:6" -h -c "$project_dir/trezor-suite/suite-native/app/e2e"
      tmux select-pane -t "$session_name:6.3"
      tmux split-window -t "$session_name:6" -h -c "$project_dir/trezor-suite/suite-native/app"
      ;;

    "job")
      parent_dir="$HOME/workspace/$session_name"
      mkdir -p $parent_dir
      get_repo "online-cv" "$parent_dir/online-cv"
      # get_repo "vuepress-cv" "$parent_dir/vuepress-cv"
      ;;
    
    "articles")
      parent_dir="$HOME/workspace/$session_name"
      get_repo "$session_name" "$parent_dir"

      new_window "$session_name" 1 "articles" "$parent_dir"
      tmux split-window -t "$session_name:1" -v -c "$parent_dir" -d
      new_window "$session_name" 2 "vuepress" "$parent_dir"
      ;;

    "conduit")
      parent_dir="$HOME/workspace/project"
      repo_name="realworld-app-conduit"
      mkdir -p $parent_dir
      get_repo "$repo_name" "$parent_dir/$repo_name"

      new_window "$session_name" 1 "$session_name" "$parent_dir/$repo_name"
      tmux split-window -t "$session_name:1" -v
      tmux split-window -t "$session_name:1" -h
      ;;

    "hackerrank" | "js-bootcamp")
      parent_dir="$HOME/workspace/learn"
      mkdir -p "$parent_dir"
      get_repo "$session_name" "$parent_dir/$session_name"

      new_window "$session_name" 1 "$session_name" "$parent_dir/$session_name"
      tmux split-window -t "$session_name:1" -v
      tmux split-window -t "$session_name:1" -h
      ;;
    
    "epic")
      parent_dir="$HOME/workspace/learn/epic"
      mkdir -p "$parent_dir"
      get_repo "testing-javascript" "$parent_dir/testing-javascript"
      # get_repo "epic-react" "$parent_dir/epic-react"

      new_window "$session_name" 1 "$session_name-testing" "$parent_dir/testing-javascript"
      tmux split-window -t "$session_name:1" -v
      tmux split-window -t "$session_name:1" -h
      # new_window "$session_name" 2 "$session_name-react" "$parent_dir/epic-react"
      # tmux split-window -t "$session_name:2" -v
      # tmux split-window -t "$session_name:2" -h
      ;;

    "playwright-course")
      parent_dir="$HOME/workspace/learn"
      mkdir -p "$parent_dir"
      get_repo "provider-pw-start" "$parent_dir/provider-pw-start"
      get_repo "consumer-pw-start" "$parent_dir/consumer-pw-start"

      new_window "$session_name" 1 "provider" "$parent_dir/provider-pw-start"
      tmux split-window -t "$session_name:1" -v
      tmux split-window -t "$session_name:1" -h
      new_window "$session_name" 2 "consumer" "$parent_dir/consumer-pw-start"
      tmux split-window -t "$session_name:2" -v
      tmux split-window -t "$session_name:2" -h
      ;;
  esac
  
  # Removes the inaccessible window 0
  sleep 1
  tmux unlink-window -k -t "$session_name":0
}

echo "Starting tmux server..."
tmux start-server

for s in "${SESSION[@]}"; do
  if ! has_session "$s"; then
    echo "Createing session '$s'..."
    tmux new-session -d -s "$s"
    set_session "$s"
    echo "Session '$s' has been created successfully."
  else 
    echo "Session '$s' already exists. Skipping."
  fi
done

tmux attach-session -t $ATTACH_SESSION:3
