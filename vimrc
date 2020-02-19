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

" use system clipboard,
" cross-platform solution https://stackoverflow.com/a/30691753
" set clipboard^=unnamed,unnamedplus
set clipboard=unnamedplus

" always display status line
set laststatus=2

" fix the problem wiht backspace in vim version 7.4 or higher
set backspace=2 

" get the full path of current file ctrl+g
set statusline+=%F 

" set number

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/gruvbox
set runtimepath^=~/.vim/bundle/ctrlp.vim
" ag integration into Vim
set runtimepath^=~/.vim/bundle/ag 

" Tabs and spaces
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set tags=./tags;

" Open new split panes to right and bottom, which feels more natural
set splitbelow
set splitright

" }}}
" KEY BINDINGS {{{
"
" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" fuzzy search including hidden files
" let g:ctrlp_show_hidden = 1

" Leader
let mapleader = " "

" Open :Ex
" nnoremap <C-s> <esc>:Explore<CR>
nnoremap <Leader>f :Explore<CR>
nnoremap <Leader>v :Vexplore<CR>

" Fzf
nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>

" Searching for tags
nnoremap <Leader>t :BTags<CR>
nnoremap <Leader>T :Tags<CR>

" Searching for string patterns inside files
nnoremap <Leader>a :Rg<CR>

" Single file deletion 
nnoremap <Leader>d :call delete(expand('%'))<CR>

" Rename currently opened file
nnoremap <Leader>n :call RenameFile()<CR>

" tcomment
nmap <Leader>c <c-_><c-_>

" quit vim
nnoremap <Leader>q :q<CR>

" Index ctags from any project, including those outside Rails
noremap <Leader>ct :!ctags -R --exclude=.git --exclude=node_modules --fields=+l .<CR>

" linux - copy filename/path to clipboard
" (https://vim.fandom.com/wiki/Copy_filename_to_clipboard) 
nmap ,cs :let @+=expand("%")<CR>
nmap ,cl :let @+=expand("%:p")<CR>

" }}}
" VISUAL {{{
"
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
filetype plugin indent on    " required

" NETRW config
let g:netrw_banner = 0
let g:netrw_browse_split = 0


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
au BufNewFile,BufRead *.thor set filetype=ruby
au BufNewFile,BufRead *.md set filetype=markdown
" Enable spellchecking for Markdown
au BufRead,BufNewFile *.md setlocal spell
" Automatically wrap at 80 characters for Markdown
au BufRead,BufNewFile *.md setlocal textwidth=80"
