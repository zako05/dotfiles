export FZF_DEFAULT_COMMAND='rg --files --follow --hidden'
# Fish syntax
# set -gx FZF_DEFAULT_COMMAND  'rg --files --follow --hidden'

export PATH="/usr/local/opt/curl/bin:$PATH"
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
export NVM_DIR="$HOME/.nvm"

[ -s "$HOME/.rvm/scripts/rvm" ] && \. "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[ -s "$HOME/.avn/bin/avn.sh" ] && \. "$HOME/.avn/bin/avn.sh" # load avn

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[[ -s "$HOME/.avn/bin/avn.sh" ]] && source "$HOME/.avn/bin/avn.sh" # load avn

os="$(uname -a)"
for el in ${os[*]}
do
  if [ "$el" == "Darwin" ]; then
    eval `keychain --eval --agents ssh --inherit any id_rsa_zako05`
    # enable bash shell completion
    if [ -f `brew --prefix`/etc/bash_completion  ]; then
          . `brew --prefix`/etc/bash_completion
    fi
    break
  fi
done

if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
