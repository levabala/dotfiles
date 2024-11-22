vim.g.mapleader = " "

vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })

-- omit leading space while selecting/yanking/replacing/deleting
vim.keymap.set("n", "va'", "v2i'")
vim.keymap.set("n", 'va"', 'v2i"')
vim.keymap.set("n", "va`", "v2i`")
vim.keymap.set("n", "ya'", "y2i'")
vim.keymap.set("n", 'ya"', 'y2i"')
vim.keymap.set("n", "ya`", "y2i`")
vim.keymap.set("n", "da'", "d2i'")
vim.keymap.set("n", 'da"', 'd2i"')
vim.keymap.set("n", "da`", "d2i`")
vim.keymap.set("n", "ca'", "c2i'")
vim.keymap.set("n", 'ca"', 'c2i"')
vim.keymap.set("n", "ca`", "c2i`")

-- delete without yanking
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>d", '"_d')

-- replace currently selected text with default register
-- without yanking it
vim.keymap.set("v", "<leader>p", '"_dP')

-- record relative jumps to the jumpslist
vim.cmd([[ nnoremap <expr> k (v:count > 1 ? "m'" . v:count : '') . 'k' ]])
vim.cmd([[ nnoremap <expr> j (v:count > 1 ? "m'" . v:count : '') . 'j' ]])

-- vim.keymap.set("n", "<leader>te", "<CMD>TSToolsRemoveUnusedImports sync<CR><CMD>EslintFixAll<CR>")
vim.keymap.set(
	"n",
	"<leader>te",
	"<CMD>TypescriptRemoveUnused!<CR><CMD>EslintFixAll<CR><CMD>TypescriptRemoveUnused!<CR>"
)

-- This unsets the "last search pattern" register
vim.keymap.set("n", "<CR>", ":noh<CR><CR>", { silent = true })
vim.keymap.set("n", "<ESC>", ":noh<CR>", { silent = true })

-- mirror <C-6>
vim.keymap.set("n", "<C-j>", "<C-^>", { silent = true })

-- disable auto formatting when pasting in insert mode
vim.keymap.set("i", "<C-r>", "<C-r><C-o>", { silent = true })

-- diff shortcut
vim.keymap.set("n", "<leader>gd", ":SignifyDiff<CR>", { silent = true })

-- tab close shortcut
vim.keymap.set("n", "<leader>tc", ":tabc<CR>", { silent = true })

-- eslint shortcut
vim.keymap.set("n", "<leader>ge", ":EslintFixAll<CR>", { silent = true })

-- insert mode copy current word
vim.keymap.set("i", "<C-y>", "<ESC>yiw ea", { silent = true })

-- quickfix list navigation
vim.keymap.set("n", "[q", ":cnext<CR>", { silent = true })
vim.keymap.set("n", "]q", ":cprev<CR>", { silent = true })
