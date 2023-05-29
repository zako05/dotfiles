# Dotfiles

# Install dotfiles via RCM

'rc' (as in '.zshrc') = RunCom
'rcm' = RunCom management

Install RCM:

```zsh
brew tap thoughtbot/formulae
brew install rcm
```

run 'rcup' to install/update dotfiles

```zsh
env RCRC=$HOME/dotfiles/rcrc rcup
```

# Dotfile dependencies

## Universal Ctags

links:
https://ctags.io/
https://github.com/universal-ctags/ctags/blob/master/docs/osx.rst
https://github.com/universal-ctags/homebrew-universal-ctags

```zsh
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
```

## FZF (command line fuzzy finder)

link: https://github.com/junegunn/fzf#using-git

```zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## Ripgrep (rg)

link: https://github.com/BurntSushi/ripgrep#installation

```zsh
brew install ripgrep
```

# TMUX

## [Tmux clipboard](https://bit.ly/2F3xQPd)

```zsh
set-option -s set-clipboard off
```

```zsh
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
```

## Tmux plugin manager

```zsh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

## Install Tmux plugin

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

```zsh
brew install vim
```

### [Install vim-plug](https://github.com/junegunn/vim-plug)

```zsh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

# zsh

link: https://zsh.sourceforge.io/Intro/intro_3.html

## [todo] Enable zsh shell completion

# Keychain (https://www.funtoo.org/Keychain)

```
brew install keychain
```

# Javascript development

link:
https://github.com/neoclide/coc.nvim
https://github.com/neoclide/coc-tsserver

Inside Vim, run command `:CocInstall coc-json coc-tsserver`
