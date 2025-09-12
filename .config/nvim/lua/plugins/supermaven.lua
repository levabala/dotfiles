return {
	"supermaven-inc/supermaven-nvim",
	cmd = {
        "SupermavenStart",
    },
	config = function()
		require("supermaven-nvim").setup({})
	end,
	enabled = false,
}
