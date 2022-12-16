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
" let g:netrw_keepj=""
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_keepdir = 1
let g:netrw_browse_split = 0
let g:netrw_preview = 1
let g:netrw_liststyle=0

function! NetrwMapping()
  nmap <buffer> l <CR>
  nmap <buffer> h -^
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

noremap ge :Rexplore<CR>

" loading old-fashion .vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

:lua require('theme')
:lua require('lsp')
