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
env RCRC=$HOME/dotfiles/rcrc rcup
```
# VIM
## [VIM Clipboard](https://bit.ly/2TTyubi)
Vim has to be compiled with clipboard support for this to work, and many distros come with vim package that does not have this feature.
### MacOS
You should be good to go.
### Linux (debian-based systems, e.g. ubuntu)
Check the clipboard support of your Vim.
Look for the +clipboard or +xterm_clipboard flags.
```
vim --version | grep clipboard
```
If you don't see either of those then ou will need to look for a version of Vim that was compiled with clipboard support based on your Linux distro.
#### [Install different VIM package](https://bit.ly/2F2g3Ie)
Here is a brief summary of each https://bit.ly/2XSONo2
```
sudo apt-get install vim-gnome
```
## VIM Dependencies
### Install vundle
```
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```
### [Install silver-search](https://github.com/ggreer/the_silver_searcher)
#### OS X with Homebrew
```
brew install the_silver_searcher
```
#### Linux (Ubuntu >= 13.10 (Saucy) or Debian >= 8 (Jessie))
```
sudo apt-get install silversearcher-ag
```
#### [(DEPRECATED) ag.vim - intergration silver-search into vim](https://github.com/rking/ag.vim)
```
cd ~/.vim/bundle && git clone https://github.com/rking/ag.vim ag 
```
_optional, because it's already part of vimrc_
```
echo “set runtimepath^=~/.vim/bundle/ag.vim" >> ~/.vimrc"
```
### Install ctags
#### OS X with Homebrew
```
brew install ctags
alias ctags="`brew -—prefix`/bin/ctags"
```
#### Linux (Debian-based systems)
```
sudo apt-get install exuberant-ctags
```
### Install all vim plugins
#### Install striaght from command line
```
vim +PluginInstall +qall
```
#### From vim window
```
:PluginInstall
```
# TMUX
## [TMUX clipboard](https://bit.ly/2F3xQPd)
### MacOS
_[todo] pbcopy_
### Linux (debian-based systems, e.g. ubuntu)
#### Add / Update following in 'tmux.conf' file
```
set-option -s set-clipboard off
```
##### ...for xclip (prefered)
```
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
```
##### ...for [xsel](https://bit.ly/2Fep6qK)
```
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xsel -i --clipboard"
```
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
# BASH 
## Enable bash shell completion by installing bash-completion
### OS X with Homebrew
```
brew install bash-completion
```
then add the following to your ~/.bashrc <-- already added
```
if [`brew --prefix`/etc/bash_completion ]
  `brew --prefix`/etc/bash_completion
```
## Install keychain (https://www.funtoo.org/Keychain)
### OS X with Homebreww
```
brew install keychain
```
### Linux (Debian-based systems)
```
sudo apt-get install keychain
```
