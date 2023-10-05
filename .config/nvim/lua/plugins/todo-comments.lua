return {
	"folke/todo-comments.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	init = function()
		require("todo-comments").setup({
			highlight = {
				keyword = "fg",
				after = "",
			},
		})
	end,
}
