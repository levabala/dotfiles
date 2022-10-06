call plug#begin()

" common
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" visual
Plug 'tanvirtin/monokai.nvim'
Plug 'edkolev/tmuxline.vim'
" Plug 'SmiteshP/nvim-navic'

" editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" lsp and syntax
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'nvim-treesitter/nvim-treesitter-context'
Plug 'neovim/nvim-lspconfig'
Plug 'jose-elias-alvarez/typescript.nvim'
Plug 'jose-elias-alvarez/null-ls.nvim'

" internal
Plug 'nvim-lua/plenary.nvim'

cal plug#end()

set termguicolors

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" let g:airline_statusline_ontop = 1
" let g:airline_stl_path_style = 'short'
" let g:airline_section_c = "%{%v:lua.require'nvim-navic'.get_location()%}"

let g:netrw_keepdir = 0
let g:netrw_banner = 0
let g:netrw_winsize = 20
let g:netrw_keepdir = 1
let g:netrw_browse_split = 0

let g:vim_markdown_folding_disabled = 1

let g:ale_fixers = ['prettier', 'eslint']
let g:ale_lint_delay = 200
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 0

function! NetrwMapping()
  nmap <buffer> l <CR>
  nmap <buffer> h -^
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

:lua require('theme')
:lua require('lsp')
