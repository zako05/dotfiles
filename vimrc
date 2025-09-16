" GENERAL {{{

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

set encoding=utf-8

" Use Vim settings, rather then Vi settings
set nocompatible 

" Use system clipboard
set clipboard=unnamed

" Always display status line
set laststatus=2

" Keeps 8 lines of context visible above and below the cursor
set scrolloff=8

" Reserves a column on the left for signs
set signcolumn=yes

" Fix the problem wiht backspace in vim version 7.4 or higher
set backspace=2 

" Get the full path of current file ctrl+g
set statusline+=%F 

" Display line numbers
set number

" Tabs and spaces
set tabstop=2
set softtabstop=0
set shiftwidth=2
set expandtab

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set tags=./tags

" VIM swap-file directory
" Make sure the directory exists, or vim won't use it
set directory^=$HOME/.vim/swap//

" Indents based on file type, eg. type '>>' to shift 2 spaces
filetype plugin indent on

" Leader
let mapleader = " "

" Formatting every time save a file
autocmd BufWritePre *.js,*.jsx,*.ts,*.tsx,*.json,*.css,*.scss,*.html silent call CocActionAsync('format')

let g:gutentags_ctags_executable = '/opt/homebrew/bin/ctags'

" }}}
" KEY BINDINGS {{{
"
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Fzf
nnoremap <silent> <C-p> :Files<CR>
nnoremap <silent> <C-o> :Buffers<CR>

" Open :Ex
nnoremap <Leader>f :Explore<CR>
nnoremap <Leader>v :Vexplore<CR>
nnoremap <Leader>s :Sexplore<CR>
nnoremap <Leader>h :History<CR>

" Searching for tags
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>

" Searching for string patterns inside files
nnoremap <Leader>a :Rg<CR>

" tcomment
map <Leader>c <c-_><c-_>

" quit vim
nnoremap <Leader>q :q<CR>

" Index ctags from any project
noremap <Leader>ct :!ctags -R --exclude=.git --exclude=node_modules --fields=+l .<CR>

" linux - copy filename/path to clipboard
" (https://vim.fandom.com/wiki/Copy_filename_to_clipboard) 
nmap ,cs :let @+=expand("%")<CR>
nmap ,cl :let @+=expand("%:p")<CR>

"Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" }}}
" VISUAL {{{
"
" vertical line/ruler
set colorcolumn=80

" show the cursor position all the time
set ruler

" Color scheme
" The \":syntax enable\" command will keep your current color settings.
" This allows using \":highlight\" commands to set your preferred colors before or after using this command.
" If you want Vim to overrule your settings with the defaults, use: > \":syntax on\"
syntax on

" use new regular expression engine (https://jameschambers.co.uk/vim-typescript-slow)
set re=0

" theme: vim-code-dark
let g:codedark_modern=1
colorscheme codedark

set background=dark
hi ColorColumn ctermbg=238

" NETRW config
let g:netrw_banner = 0
let g:netrw_browse_split = 0

" }}}
" EDITOR {{{
"
" Automatically wrap at 80 characters for Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80
let vim_markdown_preview_hotkey='<C-m>'
