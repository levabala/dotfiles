return {
	"j-hui/fidget.nvim",
	tag = "v1.4.5",
	event = "LspAttach",
	init = function()
		require("fidget").setup({
			progress= {
				ignore = {
					'pylsp',
				}
			},
		})
	end,
}
