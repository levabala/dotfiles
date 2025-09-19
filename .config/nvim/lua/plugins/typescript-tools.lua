return {
	"pmizio/typescript-tools.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
	enabled = false,
	config = function()
		require("typescript-tools").setup({
			settings = {
				tsserver_max_memory = 32768,
				separate_diagnostic_server = false,
			},
			on_attach = function(client, bufnr)
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
			handlers = {
				["textDocument/publishDiagnostics"] = require("typescript-tools.api").filter_diagnostics({
					80001, -- convert to ES module suggestion
					80005, -- 'require' call may be converted to an import
				}),
			},
		})
	end,
}
