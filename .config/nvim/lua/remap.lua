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
vim.keymap.set("n", "<leader>te", "<CMD>TypescriptRemoveUnused!<CR><CMD>EslintFixAll<CR><CMD>TypescriptRemoveUnused!<CR>")

-- This unsets the "last search pattern" register
vim.keymap.set("n", "<CR>", ":noh<CR><CR>", { silent = true })
vim.keymap.set("n", "<ESC>", ":noh<CR>", { silent = true })

vim.keymap.set("n", "<C-j>", "<C-^>", { silent = true })
