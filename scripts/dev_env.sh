#!/bin/bash

session=(workspace vestberry)

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

set_session () {
  workspace=$HOME/$1
  if [[ "$1" == "workspace" ]] 
  then
    tmux new-window -t "${1}:2" -n articles -c "${workspace}/article-draft" -d
    tmux new-window -t "${1}:3" -n vitepress-articles -c "${workspace}/vitepress-articles" -d
    tmux new-window -t "${1}:4" -n jsbootcamp -c "${workspace}/js-bootcamp" -d \; split-window -t jsbootcamp -h -c "${workspace}/js-bootcamp" 
    tmux new-window -t "${1}:5" -n testing-javascript -c "${workspace}/testing-javascript" -d
      tmux split-window -t testing-javascript -h -c "${workspace}/testing-javascript"
      tmux split-window -t testing-javascript -c "${workspace}/testing-javascript" \; select-pane -t 1 
    tmux new-window -t "${1}:6" -n tau -c "${workspace}/tau/playwright-js-basics" -d
    tmux new-window -t "${1}:7" -n cy-tips -c "${workspace}/cypress-tips" -d \; split-window -t cy-tips -h -c "${workspace}/cypress-tips" 
    tmux new-window -t "${1}:8" -n 10-days-of-js -c "${workspace}/10-days-of-js" -d \; split-window -t 10-days-of-js -h -c "${workspace}/10-days-of-js" 
    tmux new-window -t "${1}:9" -n vue-realworld-example -c "${workspace}/vue3-realworld-example-app" -d \; split-window -t vue-realworld-example -h -c "${workspace}/vue3-realworld-example-app" 
  fi
  if [[ "$1" == "vestberry" ]] 
  then
    tmux new-window -t "${1}:2" -n vbr-client-server -c "${workspace}/vestberry" -d
      tmux split-window -t vbr-client-server -h -c "${workspace}/vestberry"
      tmux split-window -t vbr-client-server -c "${workspace}/vestberry" \; select-pane -t 1
      tmux split-window -t vbr-client-server -c "${workspace}/vestberry"
    tmux new-window -t "${1}:3" -n cy-run -c "${workspace}/vestberry" -d
    tmux new-window -t "${1}:4" -n cy-specs -c "${workspace}/vestberry" -d
  fi
}

tmux start-server
for s in "${session[@]}"
do
  if get_session $s
  then
    tmux new-session -s $s -n default -c  $HOME/$s -d
    echo "Session $s has been created successfully."
    set_session $s
  fi
done
