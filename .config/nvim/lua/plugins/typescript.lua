return {
	"jose-elias-alvarez/typescript.nvim",
	init = function()
		require("typescript").setup({
			go_to_source_definition = {
				fallback = true,
			},
		})
	end,
	enabled = false,
}
