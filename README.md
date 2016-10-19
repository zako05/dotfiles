#Dotfiles
##Install rcm
###OS X with Homebrew
```
brew tap thoughtbot/formulae
brew install rcm
```
###Linux (debian-based systems)
```
sudo add-apt-repository ppa:martin-frost/thoughtbot-rcm
sudo apt-get update
sudo apt-get install rcm
```
##Install dotfiles
```
env RCRC=$HOME/workspace/dotfiles/rcrc rcup
```
#VIM Dependencies
##Install vundle
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
##Install silver-search
###OS X with Homebrew
```
brew install the_silver_searcher
```
###Linux (Debian-based systems)
```
sudo apt-get install silversearcher-ag
```
##Install ctags
###OS X with Homebrew
```
brew install ctags
alias ctags=“`brew —prefix`/bin/ctags”
```
###Linux (Debian-based systems)
```
sudo apt-get install exuberant-ctags
```
##Install all vim plugins
### install striaght from command line
```
vim +PluginInstall +qall
```
### from vim window
```
:PluginInstall
```
 
