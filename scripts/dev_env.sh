#!/bin/bash

# main working directory
WORKSPACE=$HOME/workspace
# add all sessions you want to create
session=( workspace )

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

# add additional settings for particular session
set_session () {
# WORKSPACE
if [ "$1" == "workspace" ]
then
  tmux new-window -n articles -t workspace -c $WORKSPACE/article-draft -d
  tmux new-window -n jsbootcamp -t workspace -c $WORKSPACE/js-bootcamp -d
  tmux new-window -n cypress -t workspace -c $WORKSPACE/cypress-e2e-tests -d
  tmux new-window -n realworld-app-vue -t workspace -c $WORKSPACE/realworld-example-app-vue3 -d
  tmux new-window -n realworld-app-hubstuff -t workspace -c $WORKSPACE/realworld-example-app-hubstuff -d
  # tmux split-window -v -t workspace -c $WORKSPACE/beta
  # tmux split-window -h -t workspace -c $WORKSPACE/beta
  # tmux resize-pane -t 1 -D 10
fi
}

for s in "${session[@]}"
do
  if get_session $s
  then
    # echo "Session $s does not exist, so it can be created." 
    if [ "$s" == "workspace" ]
    then
      tmux new -s $s -n defualt -c $HOME/$s -d
      echo "Session $s has been created successfully."
      set_session $s
    else
      tmux new -s $s -n defualt -c $WORKSPACE/$s -d
      echo "Session $s has been created successfully."
      set_session $s
    fi
  fi
done
