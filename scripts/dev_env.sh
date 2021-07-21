#!/bin/bash

session=( workspace vestberry )

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
  if [ "$1" == "workspace" ]
  then
    tmux new-window -t "${1}:2" -n articles -c "${workspace}/article-draft" -d
    tmux new-window -t "${1}:3" -n jsbootcamp -c "${workspace}/js-bootcamp" -d \; split-window -t jsbootcamp -h -c "${workspace}/js-bootcamp" 
  fi
  if [ "$1" == "vestberry" ]
  then
    tmux new-window -t "${1}:2" -n vestberry -c "${workspace}/vestberry" -d
    tmux new-window -t "${1}:3" -n vs-client-server -c "${workspace}/vestberry" -d \; split-window -t vs-client-server -h -c "${workspace}/vestberry" 
    tmux new-window -t "${1}:4" -n cypress -c "${workspace}/vestberry/cypress" -d
    tmux new-window -t "${1}:5" -n cypress-specs -c "${workspace}/vestberry/cypress/integration" -d
  fi
}

for s in "${session[@]}"
do
  echo "session: ${s}"
  if get_session $s
  then
    tmux new-session -s $s -n defualt -c  $HOME/$s -d
    echo "Session $s has been created successfully."
    set_session $s
  fi
done
