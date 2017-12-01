export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

eval `keychain --eval --agents ssh --inherit any id_rsa_michalz`
eval `keychain --eval --agents ssh --inherit any id_rsa_zako05`
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

stty start undef stop undef
alias ctags='/usr/local/bin/ctags'
