return {
	"j-hui/fidget.nvim",
	tag = "legacy",
	event = "LspAttach",
	init = function()
		require("fidget").setup({})
	end,
}
