#!/bin/zsh

session=(dotfiles todos workspace epic conduit blog resume job)

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
  if [[ "$1" == "dotfiles" ]]; then
    tmux new-window -t $1:1 -n dotfiles -c "${workspace}" -d
      tmux split-window -t dotfiles -v -c "${workspace}/scripts"
    no_window_zero $1
  fi
  if [[ "$1" == "todos" ]]; then
    tmux new-window -t $1:1 -n todos -c "workspace/todos" -d
    no_window_zero $1
  fi
  if [[ "$1" == "workspace" ]]; then
    tmux new-window -t $1:1 -n hacckerrank -c "${workspace}/hackerrank" -d
    tmux new-window -t $1:2 -n pw-course -c "${workspace}/playwright-course" -d
      tmux split-window -t pw-course -v -c "${workspace}/playwright-course"
      tmux split-window -t pw-course -h -c "${workspace}/playwright-course"
    tmux new-window -t $1:3 -n jsbootcamp -c "${workspace}/js-bootcamp" -d
      tmux split-window -t jsbootcamp -v -c "${workspace}/js-bootcamp" 
      tmux split-window -t jsbootcamp -h -c "${workspace}/js-bootcamp" \; select-pane -t 1
    tmux new-window -t $1:4 -n tau -c "${workspace}/tau" -d
    tmux new-window -t $1:5 -n vue-realworld-example -c "${workspace}/vue3-realworld-example-app" -d \; split-window -t vue-realworld-example -h -c "${workspace}/vue3-realworld-example-app" 
    no_window_zero $1
  fi
  if [[ "$1" == "conduit" ]]; then
    tmux new-window -t $1:1 -n conduit -c "workspace/realworld-app-conduit" -d
      tmux split-window -t conduit -v -c "workspace/realworld-app-conduit"
      tmux split-window -t conduit -h -c "workspace/realworld-app-conduit"
    no_window_zero $1
  fi
  if [[ "$1" == "epic" ]]; then
    tmux new-window -t $1:1 -n epic-react -c "workspace/epic-react" -d
      tmux split-window -t epic-react -v -c "workspace/epic-react"
      tmux split-window -t epic-react -h -c "workspace/epic-react"
    tmux new-window -t $1:2 -n epic-testing -c "workspace/testing-javascript" -d
      tmux split-window -t epic-testing -v -c "workspace/testing-javascript"
      tmux split-window -t epic-testing -h -c "workspace/testing-javascript" \; select-pane -t 1 
    no_window_zero $1
  fi
  if [[ "$1" == "blog" ]]; then
    tmux new-window -t $1:1 -n article -c "workspace/blog" -d
      tmux split-window -t article -h -c "workspace/blog/articles"
      tmux split-window -t article -v -c "workspace/article-draft"
    no_window_zero $1
  fi
  if [[ "$1" == "resume" ]]; then
    tmux new-window -t $1:1 -n cv-jekyll -c "workspace/cv-online" -d
      tmux split-window -t cv-jekyll -v -c "workspace/cv-online" 
    tmux new-window -t $1:2 -n cv-vuepress -c "workspace/vuepress-cv" -d
    no_window_zero $1
  fi
  if [[ "$1" == "job" ]]; then
    tmux new-window -t $1:1 -n assignment -c "workspace" -d
    tmux new-window -t $1:2 -n assignment -c "workspace/assignments" -d
      tmux split-window -t assignment -v -c "workspace/assignments" 
      tmux split-window -t assignment -h -c "workspace/assignments"
    tmux new-window -t $1:3 -n satoshilabs -c "satoshilabs" -d
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
