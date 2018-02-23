export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

os="$(uname -a)"
for el in ${os[*]}
do
  if [ "$el" == "Darwin" ]; then
    eval `keychain --eval --agents ssh --inherit any id_rsa_michalz`
    eval `keychain --eval --agents ssh --inherit any id_rsa_zako05`
    # enable bash shell completion
    if [ -f `brew --prefix`/etc/bash_completion  ]; then
          . `brew --prefix`/etc/bash_completion
    fi
    break
  fi
done

stty start undef stop undef
alias ctags='/usr/local/bin/ctags'
