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
#### Update VIM to version 7.4 if VIM version <= 7.3
NOTE: [The PPA contains the unofficial builds of fresh Vim development versions. Use it at your own risk!](http://ubuntuhandbook.org/index.php/2013/08/upgrade-vim-7-4-ubuntu/)
```
sudo add-apt-repository ppa:nmi/vim-snapshots
sudo apt-get update; sudo apt-get install vim
```
## [VIM Clipboard](https://bit.ly/2TTyubi)
Vim has to be compiled with clipboard support for this to work, and many distros come with vim package that does not have this feature.
### MacOS
#### [Install VIM](https://bit.ly/2FUxZVN)
Install VIM because default VIM that comes with OS X does not have +clipboard enabled
```
brew install vim
```
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
## Dependencies
### [Install vim-plug](https://github.com/junegunn/vim-plug)
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
### [Install silver-search](https://github.com/ggreer/the_silver_searcher)
[silver-search installation](https://github.com/ggreer/the_silver_searcher#installing)
#### OS X with Homebrew
```
brew install the_silver_searcher
```
#### Linux (Ubuntu >= 13.10 (Saucy) or Debian >= 8 (Jessie))
```
sudo apt-get install silversearcher-ag
```
### [Install exuberant ctags](https://en.wikipedia.org/wiki/Ctags#Ctags_and_Exuberant_Ctags)
#### OS X with Homebrew
```
brew install ctags
alias ctags="`brew -—prefix`/bin/ctags"
```
#### Linux (Ubuntu >= 13.10 (Saucy) or Debian >= 8 (Jessie))
```
sudo apt-get install exuberant-ctags
```
#### Linux (older versions)
[building ctags from source](https://github.com/ggreer/the_silver_searcher#building-from-source)
```
git clone https://github.com/ggreer/the_silver_searcher.git
apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
./build.sh
sudo make install
```
[difference between ctags & exuberant ctags](raju.shoutwiki.com/wiki/Difference_between_ctags_and_exuberant_ctags)
### [Install universal ctags](https://github.com/universal-ctags/ctags/blob/master/docs/osx.rst)
#### OS X with Homebrew
```
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
```
#### Linux (Ubuntu >= 13.10 (Saucy) or Debian >= 8 (Jessie))
```
sudo snap install universal-ctags
```
# TMUX
## [TMUX clipboard](https://bit.ly/2F3xQPd)
```
set-option -s set-clipboard off
```
### MacOS
#### pbcopy
```
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
```
### Linux (debian-based systems, e.g. ubuntu)
##### xclip (prefered)
```
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -i -f -selection primary | xclip -i -selection clipboard"
```
##### [xsel](https://bit.ly/2Fep6qK)
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
