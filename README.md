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

## Keyboard & Navigation Configuration

This system utilizes `skhd` for global keybindings and [launcher.keychron](https://launcher.keychron.com/) for hardware-level keyboard customization.

### Hardware (VIA)
- `Caps Lock` is remapped to `Left Control` at the firmware level.

### Global Keybindings (`skhd`)
- **Navigation:** `Ctrl + {h,j,k,l}` = `{Left, Down, Up, Right} Arrow`
- **Text Selection:** `Ctrl + Shift + {h,j,k,l}` = `Shift + Arrow`
- **Word Jumping:** `Ctrl + Opt + {h,l}` = `Alt + {Left, Right}`
- **Line Jumping:** `Ctrl + Cmd + {h,l}` = `Cmd + {Left, Right}`
- **Tilde:** `Opt + 1` = `~`

### Terminal (Ghostty) & Navigation Integration
- **Clear Screen:** `Cmd + L` is configured in Ghostty to send `\x1e` (Ctrl+^), which is bound in Zsh to `clear-screen` to clear the screen inside/outside tmux without conflicting with `Ctrl+l` (mapped to move the cursor right).
- **Shell Compatibility:** Enabled Emacs-mode in `.zshrc` (`bindkey -e`) and configured `macos-option-as-alt = true` in Ghostty config.
- **Terminal Keypress Passthrough:** `skhd` is configured to bypass `Ctrl+h/j/k/l` for terminal apps (Ghostty, iTerm, iTerm2, Terminal), passing raw control characters natively.
- **Smart Vim-Aware Navigation (tmux):** In `.tmux.conf`, `Ctrl+h/j/k/l` is dynamically handled:
  - If a Vim pane is focused, the raw `Ctrl+h/j/k/l` keys are passed through (so Vim split navigation works).
  - Otherwise, they are translated to hardware Arrow keys (`Left, Down, Up, Right`) to navigate natively in Zsh and CLI programs (like `agy`).
- **Terminal Mode (`xterm-256color`):** Ghostty is configured with `term = xterm-256color` to resolve key-mapping translation and terminal capability conflicts for Vim outside of tmux.

#### Why is this setup required? (How it works)
* **MacOS Isolation:** `skhd` is a macOS system-level hotkey daemon. It only queries the operating system for the active frontmost app, which is always **Ghostty** (the terminal). It has absolutely no visibility into what command or program (like Vim, Zsh, or `agy`) you are currently running inside that terminal window.
* **The Tmux Bridge:** Because macOS isolates terminal processes, only the terminal shell itself or **`tmux`** knows what process is currently active in your terminal pane. By using `tmux` to inspect the active pane (`ps -o state= -o comm= -t '#{pane_tty}'`), we created a bridge:
  * `skhd` says: *"If focused on Ghostty, step out of the way (`~`) and let the terminal handle the keys."*
  * `tmux` says: *"Since the terminal passed the keys to me, let me check the active pane. If Vim is running, pass it through; if not, translate it to standard Arrow keys so it works natively in shell/CLI tools."*
* **Alfred / Overlay App Navigation:** By default, search launchers like Alfred run as *non-activating panels*. macOS still reports the terminal (Ghostty) as focused, which causes `skhd` to bypass key translation and makes `Ctrl+h/j/k/l` fail inside Alfred.
  * **Fix:** Open Alfred Preferences > Appearance > Options, and set **Focusing** to **Compatibility Mode**. This forces Alfred to activate and take focus, allowing `skhd` to correctly translate keybindings to hardware Arrow keys for navigating search results.


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

