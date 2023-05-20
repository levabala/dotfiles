:lua require('plugins')

set termguicolors
set completeopt=menu,menuone,noselect

" let g:fzf_preview_window = ['right:50%', 'ctrl-/']
let g:fzf_preview_window = []
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always" --dfa-size-limit 1G
  \ -g "!*.{zip}" 
  \ -g "!{.git,node_modules,build}/*" '

let mapleader = " "

nnoremap <leader>j :Rg<cr>
nnoremap <leader>k :Files<cr>

" let g:airline_statusline_ontop = 1
" let g:airline_stl_path_style = 'short'
" let g:airline_section_c = "%{%v:lua.require'nvim-navic'.get_location()%}"

let g:vim_markdown_folding_disabled = 1

let g:ale_fixers = ['prettier', 'eslint']
let g:ale_lint_delay = 200
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 0

let g:gitblame_enabled = 0

" netrw
let g:netrw_keepj="keepj"
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_keepdir = 1
let g:netrw_browse_split = 0
let g:netrw_preview = 1
let g:netrw_liststyle=0
let g:netrw_altfile = 1
let g:netrw_localcopydircmd = 'cp -r'

hi! link netrwMarkFile Search

function! NetrwMapping()
  nmap <buffer> l <CR>
  nmap <buffer> h -^
  nmap <buffer> gh :History<CR>
  nmap <buffer> <TAB> mf
  nmap <buffer> <S-TAB> mF
  nmap <buffer> <Leader><TAB> mu
  nmap <buffer> FF :call NetrwRemoveRecursive()<CR>
endfunction

function! NetrwRemoveRecursive()
  if &filetype ==# 'netrw'
    cnoremap <buffer> <CR> rm -r<CR>
    normal mu
    normal mf
    
    try
      normal mx
    catch
      echo "Canceled"
    endtry

    cunmap <buffer> <CR>
  endif
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" noremap ge <plug>VinegarUp
noremap ge :Oil<CR>
noremap <C-h> :Oil<CR>
noremap ga :Rexplore<CR>
noremap gh :History<CR>

" loading old-fashion .vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

nnoremap <F5> :UndotreeToggle<CR>
if has("persistent_undo")
   let target_path = expand('~/.undodir')

    " create the directory and any parent directories
    " if the location does not exist.
    if !isdirectory(target_path)
        call mkdir(target_path, "p", 0700)
    endif

    let &undodir=target_path
    set undofile
endif

nnoremap <C-l> <CR>

" omit leading space while selecting/yanking/replacing/deleting
nnoremap va' v2i'
nnoremap va" v2i"
nnoremap va` v2i`
nnoremap ya' y2i'
nnoremap ya" y2i"
nnoremap ya` y2i`
nnoremap da' d2i'
nnoremap da" d2i"
nnoremap da` d2i`
nnoremap ca' c2i'
nnoremap ca" c2i"
nnoremap ca` c2i`
"
" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d

" replace currently selected text with default register
" without yanking it
vnoremap <leader>p "_dP

" increase oldfiles limit
set shada=!,'200,<150,s10,h

:lua require('theme')
:lua require('lsp')
