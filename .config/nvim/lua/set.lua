vim.opt.guicursor = ""

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.autoindent = false
vim.opt.smartindent = true
-- vim.opt.cindent = false
-- vim.opt.indentexpr = ''

vim.opt.wrap = false

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"

-- increase oldfiles limit
vim.opt.shada = "!,'200,<150,s10,h"

-- global status line
vim.opt.laststatus = 3

-- reset to system (en) layout on normal mode
vim.cmd([[
	au VimEnter * silent !xkblayout-state set 0
	au InsertLeave * silent !xkblayout-state set 0
]])

vim.cmd([[
	au VimEnter * Copilot disable
	]])

-- vim.opt.langmap = [[ЙЦУКЕНГШЩЗХЪ/ФЫВАПРОЛДЖЭЯЧСМИТЬБЮ\,;QWERTYUIOP{}\|ASDFGHJKL:\"ZXCVBNM<>?,йцукенгшщзхъ\\фывапролджэячсмитьбю.;qwertyuiop[]\\asdfghjkl\;'zxcvbnm\,./]]
