return {
	"windwp/nvim-ts-autotag",
	init = function()
		require("nvim-ts-autotag").setup({
			enable_close = true,
			enable_rename = true,
			enable_close_on_slash = false,
		})
	end,
	lazy = false,
}
