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

" use system clipboard
set clipboard=unnamed

" always display status line
set laststatus=2

" fix the problem wiht backspace in vim version 7.4 or higher
set backspace=2 

" get the full path of current file ctrl+g
set statusline+=%F 

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/gruvbox

" Tabs and spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

set tags=./tags

" Indents based on file type, eg. type '>>' to shift 2 spaces
filetype plugin indent on

" Leader
let mapleader = " "

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

" Rename currently opened file
nnoremap <Leader>n :call RenameFile()<CR>

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

" jump between linting errors
nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)

"Use <Tab> and <S-Tab> to navigate the completion list
inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"

" format js code on demand
nmap <Leader>i <Plug>(ale_fix)

" }}}
" VISUAL {{{
"
" vertical line/ruler
set colorcolumn=120

" show the cursor position all the time
set ruler

" Color scheme
" The \":syntax enable\" command will keep your current color settings.
" This allows using \":highlight\" commands to set your preferred colors before or after using this command.
" If you want Vim to overrule your settings with the defaults, use: > \":syntax on\"
syntax enable
"https:/jameschambers.co.uk/vim-typescript-slow
set re=0
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
set background=dark
hi ColorColumn ctermbg=238

" NETRW config
let g:netrw_banner = 0
let g:netrw_browse_split = 0

" linting error indicators
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'
" [initiate variable with empty object first](https://bit.ly/3iwwtwj) 
let g:ale_fixers = {}
let g:ale_fixers['javascript'] = ['eslint']

" Fix files automatically on save
let g:ale_fix_on_save = 1

" }}}
" FUNCTIONS {{{
"
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

" }}}
" EDITOR {{{
"
" Instead to have '# vim:syntax=sh filetype=sh' define per each bash script
" so lets to define it for different syntax here
" (https://stackoverflow.com/a/2669295/9822844)
au BufNewFile,BufRead * if &syntax == '' | set syntax=sh | endif
au BufNewFile,BufRead *.md set filetype=markdown
" Enable spellchecking for Markdown
au BufRead,BufNewFile *.md setlocal spell
" Automatically wrap at 80 characters for Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80"
