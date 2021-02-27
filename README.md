# Dotfiles

## Install rcm

### MacOS

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

# Dependencies
## Universal Ctags
### MacOS
link: https://github.com/universal-ctags/ctags/blob/master/docs/osx.rst
```bash
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
```
### Linux (Ubuntu >= 13.10 (Saucy) or Debian >= 8 (Jessie))
link: https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst
Before running ./autogen.sh, install some packages
```bash
sudo apt install \
  gcc make \
  pkg-config autoconf automake \
  python3-docutils \
  libseccomp-dev \
  libjansson-dev \
  libyaml-dev \
  libxml2-dev
```
```bash
git clone https://github.com/universal-ctags/ctags.git
cd ctags
./autogen.sh 
./configure
make
sudo make install
```
or
```bash
sudo snap install universal-ctags
```

## fzf (command line fuzzy finder)

link: https://github.com/junegunn/fzf#using-git

```bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Ripgrep
link: https://github.com/BurntSushi/ripgrep#installation
### MacOS
```bash
brew install ripgrep
```
### Linux
```bash
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/11.0.2/ripgrep_11.0.2_amd64.deb
sudo dpkg -i ripgrep_11.0.2_amd64.deb
```
---
## Notes
**[Deprecated] Exuberant Ctags**
link: https://en.wikipedia.org/wiki/Ctags#Ctags_and_Exuberant_Ctags
MacOS
```bash
brew install ctags
alias ctags="`brew -—prefix`/bin/ctags"
```
Linux (Ubuntu >= 13.10 (Saucy) or Debian >= 8 (Jessie))
```bash
sudo apt-get install exuberant-ctags
```
Linux (older versions)
[building ctags from source](https://github.com/ggreer/the_silver_searcher#building-from-source)
```bash
git clone https://github.com/ggreer/the_silver_searcher.git
apt-get install -y automake pkg-config libpcre3-dev zlib1g-dev liblzma-dev
./build.sh
sudo make install
```
[difference between ctags & exuberant ctags](raju.shoutwiki.com/wiki/Difference_between_ctags_and_exuberant_ctags)
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
### [Install vim-plug](https://github.com/junegunn/vim-plug)
```
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```
# BASH 
## Enable bash shell completion by installing bash-completion
### MacOS
```
brew install bash-completion
```
then add the following to your ~/.bashrc <-- already added
```
if [`brew --prefix`/etc/bash_completion ]
  `brew --prefix`/etc/bash_completion
```
## Install keychain (https://www.funtoo.org/Keychain)
### MacOS
```
brew install keychain
```
### Linux (Debian-based systems)
```
sudo apt-get install keychain
```
