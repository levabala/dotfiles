return {
	{
		"stevearc/oil.nvim",
		opts = {},
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		init = function()
			require("oil").setup({
				keymaps = {
					["g?"] = "actions.show_help",
					["<C-l>"] = "actions.select",
					["<C-p>"] = "actions.preview",
					["<C-c>"] = "actions.close",
					["<C-j>"] = "actions.refresh",
					["<C-h>"] = "actions.parent",
					["_"] = "actions.open_cwd",
					["`"] = "actions.cd",
					["~"] = "actions.tcd",
					["g."] = "actions.toggle_hidden",
					["g\\"] = "actions.toggle_trash",
				},
				use_default_keymaps = false,
				skip_confirm_for_simple_edits = true,
				delete_to_trash = true,
			})

			vim.keymap.set("n", "ge", ":Oil<CR>")
			vim.keymap.set("n", "<C-h>", ":Oil<CR>")
		end,
	},
}
