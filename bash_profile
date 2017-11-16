source /etc/bashrc
export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/Developer/usr/bin:$PATH

# shell

export EDITOR="mate -w"
export SVN_EDITOR="mate -w"
export GIT_EDITOR="mate -w"
export GEM_EDITOR="mate"
export HISTCONTROL=erasedups
export HISTSIZE=100000
shopt -s histappend

export RUBYOPT=""
export PGOPTIONS="-c client_min_messages=WARNING"

# android studio
# export ANDROID_HOME=/Users/michalzak/Library/Android/sdk
# export PATH=$ANDROID_HOME/platform-tools:$PATH
# export PATH=$ANDROID_HOME/tools:$PATH
# export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_131.jdk/Contents/Home
# export PATH=$JAVA_HOME/bin:$PATH

# Colours
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
BLUE="\[\033[0;34m\]"
LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
WHITE="\[\033[1;37m\]"
LIGHT_GRAY="\[\033[0;37m\]"
GRAY="\[\033[1;30m\]"
PURPLE="\[\033[0;35m\]"
NONE="\[\e[0m\]"

function parse_git_branch {
  local gitdir="$(git rev-parse --git-dir 2>/dev/null)"
  [ -n "$gitdir" ] || return 1

  local rebase
  local branch

  if [ -f "$g/rebase-merge/interactive" ]; then
    rebase="|REBASE-i"
    branch="$(cat "$g/rebase-merge/head-name")"
  elif [ -d "$g/rebase-merge" ]; then
    rebase="|REBASE-m"
    branch="$(cat "$g/rebase-merge/head-name")"
  else
    if [ -d "$g/rebase-apply" ]; then
      if [ -f "$g/rebase-apply/rebasing" ]; then
        rebase="|REBASE"
      elif [ -f "$g/rebase-apply/applying" ]; then
        rebase="|AM"
      else
        rebase="|AM/REBASE"
      fi
    elif [ -f "$g/MERGE_HEAD" ]; then
      rebase="|MERGING"
    elif [ -f "$g/BISECT_LOG" ]; then
      rebase="|BISECTING"
    fi

    branch="$(git symbolic-ref HEAD 2>/dev/null)" || {

      branch="$(git describe --contains HEAD)" ||
      branch="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
      branch="unknown"

      branch="($branch)"
    }
  fi

  local unstaged
  local staged
  local stash
  local untracked

  if [ "true" = "$(git rev-parse --is-inside-work-tree 2>/dev/null)" ]; then

    git diff --no-ext-diff --ignore-submodules \
      --quiet --exit-code || unstaged="*"

    if git rev-parse --quiet --verify HEAD >/dev/null; then
      git diff-index --cached --quiet \
        --ignore-submodules HEAD -- || staged="+"
    else
      staged="#"
    fi

    git rev-parse --verify refs/stash >/dev/null 2>&1 && stash="$"

    if [ -n "$(git ls-files --others --exclude-standard)" ]; then
      untracked="%"
    fi

  elif [ "true" = "$(git rev-parse --is-inside-git-dir 2>/dev/null)" ]; then
    branch="GIT_DIR!"
  fi

  if [ -n "${1-}" ]; then
    printf "$1" "${branch##refs/heads/}$unstaged$staged$stash$untracked$rebase"
  else
    printf " (%s)" "${branch##refs/heads/}$unstaged$staged$stash$untracked$rebase"
  fi
}

function parse_ruby_version {
  local gemset=$(echo $GEM_HOME | awk -F'@' '{print $2}')
  [ "$gemset" != "" ] && gemset="@$gemset"
  local version=$(echo $MY_RUBY_HOME | awk -F'-' '{print $2}')
  # [ "$version" == "1.8.7" ] && version=""
  local full="$version$gemset"
  [ "$full" != "" ] && echo "$full "
}

export PS1="\[\033[G\]${PURPLE}\$(parse_ruby_version)${GREEN}\w${YELLOW}\$(parse_git_branch)${NONE} "
export PROMPT_COMMAND='echo -ne "\033]0;$(basename "$(dirname "$PWD")")/$(basename "$PWD")\007"'

source ~/.bashrc
cd .

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
