return {
	"zbirenbaum/copilot.lua",
	init = function()
		require("copilot").setup({
			panel = {
				enabled = true,
			},
			suggestion = {
				enabled = true,
				auto_trigger = true,
				keymap = {
					accept = "<C-l>",
					next = "<C-j>",
					prev = "<C-k>",
					dismiss = "<C-n>",
				},
			},
		})
	end,
}
