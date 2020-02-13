# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

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

. ~/.aliases

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
