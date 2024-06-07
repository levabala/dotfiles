return {
	"zbirenbaum/copilot.lua",
	init = function()
		require("copilot").setup({
			panel = {
				enabled = true,
				keymap = {
					jump_prev = "<C-k>",
					jump_next = "<C-j>",
					accept = "<C-l>",
					refresh = "gr",
					open = "<C-c>",
				},
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
