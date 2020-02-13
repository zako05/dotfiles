#!/bin/bash

# define all session
# zero session is main work directory
session=( workspace rails )

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
  case $1 in
    workspace)
      tmux new-window -n beta -t workspace -c /${session[0]}/beta
      ;;
    rails)
      if [ -d "/${session[0]}/$1" ]
      then
        tmux split-window -v -t rails -c "/${session[0]}/$1"
        tmux split-window -h -t rails -c "/${session[0]}/$1"
        tmux resize-pane -t 1 -D 10
      else
        tmux split-window -v -t rails -c /${session[0]}
        tmux split-window -h -t rails -c /${session[0]}
        tmux resize-pane -t 1 -D 10
      fi
      ;;
  esac
}

for s in "${session[@]}"
do
  if get_session $s
  then
    case $s in
      workspace)
        tmux new -s $s -n default -c /$s -d
        ;;
      *)
        if [ ! -d "${session[0]}/$s" ]
        then
          mkdir /${session[0]}/$s
        fi
        tmux new -s $s -n default -c "/${session[0]}/$s" -d
        ;;
    esac
    set_session $s
    echo "Session $s has been created successfully."
  fi
done
# tmux attach -t workspace
