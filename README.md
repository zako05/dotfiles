# Dotfiles
## Install rcm
### OS X with Homebrew
```
brew tap thoughtbot/formulae
brew install rcm
```
### Linux (debian-based systems)
```
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
```
or

_this works in most of the cases_
```
wget -qO - https://apt.thoughtbot.com/thoughtbot.gpg.key | sudo apt-key add -
echo "deb http://apt.thoughtbot.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/thoughtbot.list
```
```
sudo apt-get update
sudo apt-get install rcm
```
## Install dotfiles
```
env RCRC=$HOME/workspace/dotfiles/rcrc rcup
```
# VIM Dependencies
## Install vundle
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
## Install silver-search
### OS X with Homebrew
```
brew install the_silver_searcher
```
### Linux (Debian-based systems)
```
sudo apt-get install silversearcher-ag
```
### Intergration into vim
```
cd ~/.vim/bundle && git clone https://github.com/rking/ag.vim ag 
```
_optional, because it's already part of vimrc_
```
echo “set runtimepath^=~/.vim/bundle/ag.vim" >> ~/.vimrc"
```
## Install ctags
### OS X with Homebrew
```
brew install ctags
alias ctags=“`brew —prefix`/bin/ctags”
```
### Linux (Debian-based systems)
```
sudo apt-get install exuberant-ctags
```
## Install all vim plugins
### Install striaght from command line
```
vim +PluginInstall +qall
```
### From vim window
```
:PluginInstall
```
# TMUX
## Install tmux plugin manager
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
### type this in terminal if tmux is already running 
```
tmux source ~/.tmux.conf
```
or
```
prefix-: source ~/.tmux.conf
```
## Install tmux plugin(s)
```
add new pugin to ~/.tmux.conf with set -g @plugin '...'
```
```
press prefix + I to fetch the plugin
```
