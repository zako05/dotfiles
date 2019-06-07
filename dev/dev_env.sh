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

# if [ "$1" == "workspace" ]
# then
#   tmux new-window -n beta -t workspace -c /${session[0]}/beta
#   # tmux split-window -v -t workspace -c $WORKSPACE/beta
#   # tmux split-window -h -t workspace -c $WORKSPACE/beta
#   # tmux resize-pane -t 1 -D 10
# fi
# if [ "$1" == "rails" ]
# then
#   if [ -d "/${session[0]}/$1" ]
#   then
#     tmux split-window -v -t rails -c "/${session[0]}/$1"
#     tmux split-window -h -t rails -c "/${session[0]}/$1"
#     tmux resize-pane -t 1 -D 10
#   else
#     tmux split-window -v -t rails -c /${session[0]}
#     tmux split-window -h -t rails -c /${session[0]}
#     tmux resize-pane -t 1 -D 10
#   fi
# fi
}

for s in "${session[@]}"
do
  if get_session $s
  then
    # echo "Session $s does not exist, so it can be created." 
    case $s in
      workspace)
        tmux new -s $s -n default -c /$s -d
        ;;
      *)
        if [ -d ${session[0]}/$s ]
        then
          tmux new -s $s -n default -c "/${session[0]}/$s" -d
        else
          tmux new -s $s -n default -c "/${session[0]}" -d
        fi
        ;;
    esac
        

    # if [ "$s" == "workspace" ]
    # then
    #   tmux new -s $s -n default -c /$s -d
    # else
    #   if [ -d ${session[0]}/$s ]
    #   then
    #     tmux new -s $s -n default -c "/${session[0]}/$s" -d
    #   else
    #     tmux new -s $s -n default -c "/${session[0]}" -d
    #   fi
    # fi
    set_session $s
    echo "Session $s has been created successfully."
  fi
done
