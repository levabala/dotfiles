return {
	"nvim-treesitter/nvim-treesitter-context",
	after = "nvim-treesitter",
	requires = "nvim-treesitter/nvim-treesitter",
	init = function()
		require("treesitter-context").setup({
			max_lines = 10,
		})
	end,
}
