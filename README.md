# Dotfiles

## RCM (RunCom management)

`rc` (as in `.zshrc`) = RunCom
`rcm` = RunCom management

### Install RCM

```zsh
brew tap thoughtbot/formulae
brew install rcm
```

### Install/Update Dotfiles

Run `rcup` to install or update dotfiles:

```zsh
env RCRC=$HOME/dotfiles/rcrc rcup
```

## External Dependencies

### [Universal Ctags](https://ctags.io/)

Documentation:
- [OS X installation](https://github.com/universal-ctags/ctags/blob/master/docs/osx.rst)
- [Homebrew formula](https://github.com/universal-ctags/homebrew-universal-ctags)

```zsh
brew tap universal-ctags/universal-ctags
brew install --HEAD universal-ctags
```

### [FZF](https://github.com/junegunn/fzf) (Command-line fuzzy finder)

```zsh
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

### [Ripgrep (rg)](https://github.com/BurntSushi/ripgrep)

```zsh
brew install ripgrep
```

# TMUX

## [Clipboard Support](https://bit.ly/2F3xQPd)

```zsh
set-option -s set-clipboard off
```

```zsh
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "pbcopy"
```

## [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm)

```zsh
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

### Install Plugins

1. Add new plugin to `~/.tmux.conf` with `set -g @plugin '...'`
2. Press `prefix` + `I` (capital I) to fetch and install the plugin.

# VIM

## Installation

### macOS
Default Vim that comes with macOS does not have `+clipboard` enabled. Install via Homebrew:
```zsh
brew install vim
```

### Ubuntu
To update Vim to version 7.4+ (if version <= 7.3):
> **Note:** [Official PPA](http://ubuntuhandbook.org/index.php/2013/08/upgrade-vim-7-4-ubuntu/) contains development versions. Use at your own risk.

```bash
sudo add-apt-repository ppa:nmi/vim-snapshots
sudo apt-get update
sudo apt-get install vim
```

## [Clipboard Support](https://bit.ly/2TTyubi)

Vim must be compiled with clipboard support (`+clipboard`).

## [vim-plug](https://github.com/junegunn/vim-plug) (Plugin Manager)

```zsh
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

# ZSH

Official site: [zsh.sourceforge.io](https://zsh.sourceforge.io/Intro/intro_3.html)

- [ ] Enable zsh shell completion

# [Keychain](https://www.funtoo.org/Keychain)

```zsh
brew install keychain
```

# JavaScript Development

- [coc.nvim](https://github.com/neoclide/coc.nvim)
- [coc-tsserver](https://github.com/neoclide/coc-tsserver)

Inside Vim, run `:CocInstall coc-json coc-tsserver`

