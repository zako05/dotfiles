#!/bin/bash

session=(workspace instea)

get_session () {
  get_session_name=$(tmux ls | grep $1 | awk '{print $1}')
  if [ "$get_session_name" != "$1:" ]
  then
    echo "Session $1 does not exist."
    return 0
  else
    echo "Session $1 exists."
    return 1
  fi
}

# Gets rid of window 0, which is not accessible right away (hence sleep 1)
no_window_zero () {
  sleep 1
  tmux unlink-window -k -t $1:0
}

set_session () {
  workspace=$HOME/$1
  if [[ "$1" == "workspace" ]] 
  then
    tmux new-window -t $1:1 -n dotfiles -c "dotfiles" -d
    tmux new-window -t $1:2 -n vitepress-articles -c "${workspace}/vitepress-articles" -d
    tmux new-window -t $1:3 -n jsbootcamp -c "${workspace}/js-bootcamp" -d
      tmux split-window -t jsbootcamp -h -c "${workspace}/js-bootcamp" 
      tmux split-window -t jsbootcamp -c "${workspace}/js-bootcamp" \; select-pane -t 1
    tmux new-window -t $1:4 -n testing-javascript -c "${workspace}/testing-javascript" -d
      tmux split-window -t testing-javascript -h -c "${workspace}/testing-javascript"
      tmux split-window -t testing-javascript -c "${workspace}/testing-javascript" \; select-pane -t 1 
    tmux new-window -t $1:5 -n tau -c "${workspace}/tau" -d
    tmux new-window -t $1:6 -n cy-tips -c "${workspace}/cypress-tips" -d \; split-window -t cy-tips -h -c "${workspace}/cypress-tips" 
    tmux new-window -t $1:7 -n 10-days-of-js -c "${workspace}/10-days-of-js" -d \; split-window -t 10-days-of-js -h -c "${workspace}/10-days-of-js" 
    tmux new-window -t $1:8 -n vue-realworld-example -c "${workspace}/vue3-realworld-example-app" -d \; split-window -t vue-realworld-example -h -c "${workspace}/vue3-realworld-example-app" 
    tmux new-window -t $1:9 -n todos -c "${workspace}/todos" -d
    no_window_zero $1
  fi
  if [[ "$1" == "instea" ]] 
  then
    tmux new-window -t $1:1 -n instea -c "${workspace}" -d
    tmux new-window -t $1:2 -n quick -c "${workspace}/quick/quick-online-v2" -d
      tmux split-window -t quick -h -c "${workspace}/quick/quick-online-v2"
      tmux split-window -t quick -c "${workspace}/quick/quick-online-v2"
    tmux new-window -t $1:3 -n quick-dd -c "${workspace}/quick/quick-driver-dispatch/src/app" -d
      tmux send-keys -t quick-dd "nvm use 16 && yarn start" enter
      tmux split-window -t quick-dd -v -c "${workspace}/quick/quick-driver-dispatch/src/api"
        tmux send-keys -t quick-dd "nvm use 16 && yarn start" enter
      tmux split-window -t quick-dd -h -c "${workspace}/quick/quick-driver-dispatch/test/quick-test-app"
        tmux send-keys -t quick-dd "nvm use 16 && PORT=3001 yarn start" enter
      tmux split-window -t quick-dd -v -c "${workspace}/quick/quick-driver-dispatch"
        tmux send-keys -t quick-dd "docker-compose -f docker-compose-local.yml up" enter
      tmux split-window -t quick-dd -v -c "${workspace}/quick/quick-driver-dispatch"
    tmux select-layout -t quick-dd tiled
    tmux new-window -t $1:4 -n quick-dd-k6 -c "${workspace}/quick/quick-driver-dispatch/src/api/test/k6" -d
    no_window_zero $1
  fi
}

tmux start-server
for s in "${session[@]}"
do
  if get_session $s
  then
    # tmux new-session -d -s $s -n default -c $HOME/$s
    tmux new-session -d -s $s
    set_session $s
    echo "Session $s has been created successfully."
  fi
done
