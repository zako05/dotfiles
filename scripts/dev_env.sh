#!/bin/zsh

# Add homebrew to PATH
export PATH="/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

tmux() {
  /opt/homebrew/bin/tmux "$@"
}

# Configuration variables
readonly SESSION=(dotfiles todos satoshilabs job articles conduit hackerrank epic js-bootcamp playwright-course)
readonly ATTACH_SESSION="satoshilabs"
readonly DEFAULT_GITHUB_USER="zako05"

# --- Helper Functions ---

source "$(dirname "$0")/satoshilabs.sh"

has_session () {
  tmux has-session -t "$1" &> /dev/null
}

new_window () {
  local session_name="$1"
  local window_index="$2"
  local window_name="$3"
  local window_path="$4"

  if tmux list-windows -t "$session_name" -F "#{window_index}" | grep -q "^${window_index}$"; then
    tmux rename-window -t "${session_name}:${window_index}" "${window_name}"
    tmux send-keys -t "${session_name}:${window_index}" "cd \"${window_path}\" && clear" C-m
  else
    tmux new-window -t "${session_name}:${window_index}" -n "${window_name}" -c "${window_path}" -d
  fi
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

      new_window "$session_name" 1 "$session_name" "$project_dir"
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

      # If no file exists for this year yet, generate the new one
      if [[ -z "$latest_file" ]]; then
        local year_month=$(date +%Y%m)
        latest_file="$year_dir/$year_month-dev.todo.md"
        echo "Creating new file $latest_file"
        touch "$latest_file"
      fi
      
      local ideas_file="$year_dir/$current_year-dev-ideas.todo.md"
      [[ ! -f "$ideas_file" ]] && touch "$ideas_file"

      new_window "$session_name" 1 "$session_name-dev" "$year_dir"
      tmux send-keys -t "$session_name:1" "vim \"$latest_file\"" C-m
      tmux split-window -t "$session_name:1" -v -c "$year_dir"
      tmux send-keys -t "$session_name:1.2" "vim \"$ideas_file\"" C-m
      new_window "$session_name" 2 "$session_name-sm" "$project_dir"
      tmux send-keys -t "$session_name:2" "vim sm.todo.md" C-m
      ;;
    
    "satoshilabs")
      setup_satoshilabs_session "$session_name"
      ;;

    "job")
      parent_dir="$HOME/workspace/$session_name"
      mkdir -p $parent_dir
      get_repo "online-cv" "$parent_dir/online-cv"
      new_window "$session_name" 1 "online-cv" "$parent_dir/online-cv"
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

  if [[ "$s" == "satoshilabs" ]]; then
    update_satoshilabs_test_windows
  fi
done

tmux attach-session -t $ATTACH_SESSION:3
