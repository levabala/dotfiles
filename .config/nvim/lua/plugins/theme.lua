return {
	{
		"folke/tokyonight.nvim",
		init = function()
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = false,
	},
	{
		"cpea2506/one_monokai.nvim",
		init = function()
			vim.cmd.colorscheme("one_monokai")
		end,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = false,
	},
	{
		"navarasu/onedark.nvim",
		init = function()
			require("onedark").setup({ style = "darker" })
			require("onedark").load()
		end,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = false,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		init = function()
			vim.cmd.colorscheme("catppuccin")
		end,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = false,
	},
	{
		"sainnhe/everforest",
		init = function()
			vim.opt.background = "dark"

			-- Available values: 'hard', 'medium'(default), 'soft'
			vim.g.everforest_background = "medium"

			vim.cmd.colorscheme("everforest")
		end,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = false,
	},
	{
		"savq/melange-nvim",
		init = function()
			vim.cmd.colorscheme("melange")
		end,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = false,
	},
	{
		"sainnhe/sonokai",
		init = function()
			vim.g.sonokai_style = "espresso"
			-- vim.g.sonokai_style = "maia"
			-- vim.g.sonokai_style = "shusia"
			vim.cmd([[colorscheme sonokai]])
		end,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = false,
	},
	{
		"tanvirtin/monokai.nvim",
		init = function()
			require("monokai").setup({
				palette = {
					base2 = "#302c2b",
				},
				italics = false,
			})
		end,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = false,
	},
	{
		"loctvl842/monokai-pro.nvim",
		init = function()
			require("monokai-pro").setup({
				filter = "ristretto",
				terminal_colors = true
			})

			vim.cmd([[colorscheme monokai-pro]])
		end,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		enabled = true,
	},
}
