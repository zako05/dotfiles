#!/bin/zsh

source $HOME/.env

toggle_proxy() {
  if [[ -z "$http_proxy" ]]; then
    # Enable proxy
    export http_proxy="$HTTP_PROXY"
    export https_proxy="$HTTPS_PROXY"
    echo "Proxy enabled"
  else
    # Disable proxy
    unset http_proxy
    unset https_proxy
    echo "Proxy disabled"
  fi

  # Update Git configuration
  # git config --global --unset http.proxy
  # git config --global --unset https.proxy

  # if [[ -n "$http_proxy" ]]; then
  #   git config --global http.proxy "$http_proxy"
  #   git config --global https.proxy "$https_proxy"
  # fi
}
