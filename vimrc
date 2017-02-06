" Use Vim settings, rather then Vi settings
set nocompatible

" ag integration into Vim
set runtimepath^=~/.vim/bundle/ag

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/gruvbox
set rtp+=~/.vim/bundle/Vundle.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" fix the problem wiht backspace in vim version 7.4 or higher
set backspace=2

" use system clipboard
" set clipboard=unnamedplus
" set clipboard=unnamed
set clipboard^=unnamed
" set clipboard+=unnamedplus

" always display status line
set laststatus=2

" get the full path of current file ctrl+g
set statusline+=%F

" Tabs and spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" vertical line/ruler
set colorcolumn=80 
" show the cursor position all the time
set ruler

" Color scheme
syntax enable
" syntax on
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
set background=dark
hi ColorColumn ctermbg=238

" Numbers
" set numberwidth=6
" set relativenumber
set number

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Leader
let mapleader = " "

" Search for string patterns inside files
map <Leader>a :Ag

" Toggle NERDTree
map <Leader>f :NERDTreeToggle<CR>

" Rename currently opened file
map <Leader>n :call RenameFile()<CR>

" tcomment
map <Leader>c <c-_><c-_>

" quit vim
map <Leader>q :q<CR>

" fuzzy tag
map <Leader>. :CtrlPTag<CR>

" Index ctags from any project, including those outside Rails
map <Leader>ct :!ctags -R .<CR>

" emmet remap abbreviation expander from <C-y>, to use tab key 
" imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

call vundle#begin('~/.vim/bundle')

" let Vundle manage Vundle,
Plugin 'VundleVim/Vundle.vim'

Plugin 'tomtom/tcomment_vim'
Plugin 'scrooloose/nerdTree'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'mattn/emmet-vim'
Plugin 'rizzatti/dash.vim'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
" Plugin 'tpope/vim-cucumber'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-eunuch'
Plugin 'slim-template/vim-slim'
Plugin 'airblade/vim-gitgutter'
Plugin 'vim-ruby/vim-ruby'
Plugin 'morhetz/gruvbox'
Plugin 'jiangmiao/auto-pairs'
Plugin 'jelera/vim-javascript-syntax'
Plugin 'kchmck/vim-coffee-script'

call vundle#end()

filetype plugin indent on    " required

" Give a shortcut key to NERDTree
map <F2> :NERDTreeToggle<CR>

" Show line numbers and hidden files in NERD tree
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
	exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
	exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('rb', 'red', 'none', '#F62217', '#151515')
" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('scss', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'brown', 'none', '#6F4E37', '#151515')
call NERDTreeHighlightFile('js', 'brown', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'magenta', 'none', '#ff00ff', '#151515')

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" Rename file which is opened in current buffer
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
