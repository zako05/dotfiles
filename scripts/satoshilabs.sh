#!/bin/zsh

# --- Satoshilabs/Suite Specific Functions ---

setup_suite_layout () {
  local session="$1"
  local window_target="$2"
  local path="$3"

  tmux split-window -t "${session}:${window_target}" -v -c "$path"
  tmux send-keys -t "${session}:${window_target}.1" "gemini" C-m
  tmux select-pane -t "${session}:${window_target}.1"
  tmux split-window -t "${session}:${window_target}" -h -c "$path/suite/e2e"
  tmux select-pane -t "${session}:${window_target}.3"
  tmux split-window -t "${session}:${window_target}" -h -c "$path"
  # tmux send-keys -t "${session}:${window_target}.3" "git submodule update --init --recursive && git lfs pull && yarn && yarn build:libs && yarn suite:dev" C-m
}

update_satoshilabs_test_windows () {
  local session_name="satoshilabs"
  local project_dir="$HOME/$session_name"

  # Dynamic test-* windows
  for test_dir in "$project_dir"/test-*(N/); do
    local name=$(basename "$test_dir")
    if ! tmux list-windows -t "$session_name" -F "#{window_name}" | grep -q "^${name}$"; then
      echo "Adding window for $name"
      
      # Let tmux pick the next available index and return it
      local idx=$(tmux new-window -t "$session_name" -n "$name" -c "$test_dir" -d -P -F "#{window_index}")
      setup_suite_layout "$session_name" "$idx" "$test_dir"
    fi
  done

  # Remove windows whose directories no longer exist
  tmux list-windows -t "$session_name" -F "#{window_name}" | grep "^test-" | while read -r win_name; do
    if [[ ! -d "$project_dir/$win_name" ]]; then
      echo "Removing window $win_name"
      tmux kill-window -t "${session_name}:${win_name}"
    fi
  done
}

setup_satoshilabs_session () {
  local session_name="$1"
  local project_dir="$HOME/$session_name"
  
  mkdir -p "$project_dir"
  get_repo "trezor-suite" "$project_dir/trezor-suite" "trezor"
  get_repo "trezor-user-env" "$project_dir/trezor-user-env" "trezor"

  new_window "$session_name" 1 "tmp-docs" "$project_dir/docs"
  tmux split-window -t "$session_name:1" -h -c "$project_dir/tmp/screencast"
  tmux select-pane -t "$session_name:1.1"
  tmux split-window -t "$session_name:1" -v -c "$project_dir/tmp"
  new_window "$session_name" 2 "suite-docs" "$project_dir/trezor-suite/suite/e2e/docs"
  tmux split-window -t "$session_name:2" -h -c "$project_dir/trezor-suite/suite/docs"
  new_window "$session_name" 3 "suite" "$project_dir/trezor-suite"
  setup_suite_layout "$session_name" 3 "$project_dir/trezor-suite"
  new_window "$session_name" 4 "suite-native" "$project_dir/trezor-suite/suite-native/app"
  tmux split-window -t "$session_name:4" -v -c "$project_dir/trezor-suite/suite-native/app"
  tmux select-pane -t "$session_name:4.1"
  tmux split-window -t "$session_name:4" -h -c "$project_dir/trezor-suite/suite-native/app/e2e"
  tmux select-pane -t "$session_name:4.3"
  tmux split-window -t "$session_name:4" -h -c "$project_dir/trezor-suite/suite-native/app"
  new_window "$session_name" 5 "trezor-user-env" "$project_dir/trezor-user-env"
  tmux split-window -t "$session_name:5" -v -c "$project_dir/trezor-user-env"
  tmux send-keys -t "$session_name:5.1" "gemini" C-m
  tmux select-pane -t "$session_name:5.1" 
  tmux split-window -t "$session_name:5" -h -c "$project_dir/trezor-user-env"
  tmux select-pane -t "$session_name:5.3" 
  tmux split-window -t "$session_name:5" -h -c "$project_dir/trezor-suite/packages/trezor-user-env-link"
  tmux send-keys -t "$session_name:5.3" "git fetch origin && git rebase origin/master && ./run.sh" C-m
  tmux send-keys -t "$session_name:5.4" "vim src/api.ts" C-m
  new_window "$session_name" 6 "suite-analytics" "$project_dir/trezor-suite/"
  tmux split-window -t "$session_name:6" -h -c "$project_dir/trezor-suite/suite-common/analytics"
  tmux send-keys -t "$session_name:6.1" "yarn workspace @trezor/analytics-docs build-data && yarn workspace @trezor/analytics-docs dev" C-m
  tmux send-keys -t "$session_name:6.2" "vim README.md" C-m
}
