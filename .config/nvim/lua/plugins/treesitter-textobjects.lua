return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	after = "nvim-treesitter",
	requires = "nvim-treesitter/nvim-treesitter",
	init = function()
		require("nvim-treesitter.configs").setup({
		})
	end,
}
