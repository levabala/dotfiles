return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	init = function()
		require("nvim-treesitter.configs").setup({
			indent = {
				enable = true,
			},
			highlight = {
				enable = true,
			},
			context_commentstring = {
				enable = true,
			},
			textobjects = {
				select = {
					enable = true,
					lookahead = false,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
					},
					selection_modes = {
						["@parameter.outer"] = "v",
						["@function.outer"] = "V",
					},
					include_surrounding_whitespace = false,
				},
			},
		})
	end,
}
