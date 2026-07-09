" COC.NVIM NODE.JS PATH RESOLUTION
"
" This script dynamically resolves and caches the Node.js executable path for coc.nvim.
" 
" Why is this needed?
" 1. coc.nvim requires Node.js to be executable at startup.
" 2. If Vim is launched outside of an interactive terminal, NVM might not be loaded in the PATH.
" 3. Sourcing NVM (nvm.sh) dynamically at Vim startup is slow (0.8s to 3s).
"
" Solution:
" We cache the resolved Node.js path in ~/.vim/.coc_node_path.
" - On startup: Read the path from the cache file. If it exists and is valid, load it instantly (0ms overhead).
" - Fallback/Self-healing: If the cache is missing or points to a deleted Node version, query the system/NVM,
"   resolve the new path, and write it to the cache file.
"
let s:cache_file = expand('~/.vim/.coc_node_path')

" 1. Try reading the path from the cache file
if filereadable(s:cache_file)
  let s:cached_path = trim(readfile(s:cache_file)[0])
  if executable(s:cached_path)
    let g:coc_node_path = s:cached_path
  endif
endif

" 2. Fallback to active shell or NVM if cache is missing/stale
if !exists('g:coc_node_path')
  if executable('node')
    " Use the Node path from the active shell's environment
    let g:coc_node_path = exepath('node')
  else
    " Load NVM and find the default Node.js version path
    let g:coc_node_path = trim(system('source ~/.nvm/nvm.sh && nvm which default'))
  endif
  
  " 3. Save the newly resolved valid path to the cache file
  if executable(g:coc_node_path)
    if !isdirectory(expand('~/.vim'))
      call mkdir(expand('~/.vim'), 'p')
    endif
    call writefile([g:coc_node_path], s:cache_file)
  endif
endif
