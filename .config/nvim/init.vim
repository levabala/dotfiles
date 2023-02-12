:lua require('plugins')

set termguicolors
set completeopt=menu,menuone,noselect

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" let g:airline_statusline_ontop = 1
" let g:airline_stl_path_style = 'short'
" let g:airline_section_c = "%{%v:lua.require'nvim-navic'.get_location()%}"

let g:vim_markdown_folding_disabled = 1

let g:ale_fixers = ['prettier', 'eslint']
let g:ale_lint_delay = 200
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 0

" netrw
let g:netrw_keepj="keepj"
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_keepdir = 1
let g:netrw_browse_split = 0
let g:netrw_preview = 1
let g:netrw_liststyle=0
let g:netrw_altfile = 1

let g:gitblame_enabled = 0

function! NetrwMapping()
  nmap <buffer> l <CR>
  nmap <buffer> h -^
  nmap <buffer> gh :History<CR>
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

noremap ge :Explore<CR>
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

:lua require('theme')
:lua require('lsp')
