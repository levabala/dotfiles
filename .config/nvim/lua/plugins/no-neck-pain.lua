return {
	"shortcuts/no-neck-pain.nvim",
	version = "*",
	lazy = false,
	init = function()
		require("no-neck-pain").setup({
			width = 110,
			autocmds = {
				enableOnVimEnter = true,
			},
			mappings = {
				enabled = true,
				toggle = "<Leader>a",
			},
		})
	end,
}
