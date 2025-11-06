return {
	"folke/sidekick.nvim",
	opts = {
		cli = {
			watch = true,
			win = {
				layout = "float", ---@type "float"|"left"|"bottom"|"top"|"right"
				split = {
					width = 80,
					height = 20,
				},
				float = {
					width = 0.9,
					height = 0.9,
				},
				keys = {
					hide_t = {
						"<c-q>",
						function(term)
							term:hide()
						end,
						mode = "t",
					},
				},
			},
			context = {
				diagnostics_error = function(ctx)
					local Diag = require("sidekick.cli.context.diagnostics")
					return Diag.get(ctx, { severity = vim.diagnostic.severity.ERROR })
				end,
				diagnostics_error_all = function(ctx)
					local Diag = require("sidekick.cli.context.diagnostics")
					return Diag.get(ctx, { all = true, severity = vim.diagnostic.severity.ERROR })
				end,
			},
			prompts = {
				diagnostics_error = "Can you help me fix the errors in {file}?\n{diagnostics_error}",
				diagnostics_error_all = "Can you help me fix these errors?\n{diagnostics_error_all}",
			},
		},
	},
	keys = {
		{
			"<leader>aa",
			function()
				require("sidekick.cli").toggle()
			end,
			desc = "Sidekick Toggle CLI",
		},
		{
			"<leader>as",
			function()
				require("sidekick.cli").select()
			end,
			-- Or to select only installed tools:
			-- require("sidekick.cli").select({ filter = { installed = true } })
			desc = "Select CLI",
		},
		{
			"<leader>at",
			function()
				require("sidekick.cli").send({ msg = "{this}" })
			end,
			mode = { "x", "n" },
			desc = "Send This",
		},
		{
			"<leader>av",
			function()
				require("sidekick.cli").send({ msg = "{selection}" })
			end,
			mode = { "x" },
			desc = "Send Visual Selection",
		},
		{
			"<leader>ap",
			function()
				require("sidekick.cli").prompt()
			end,
			mode = { "n", "x" },
			desc = "Sidekick Select Prompt",
		},
		{
			"<c-.>",
			function()
				require("sidekick.cli").focus()
			end,
			mode = { "n", "x", "i", "t" },
			desc = "Sidekick Switch Focus",
		},
		{
			"<c-q>",
			function()
				require("sidekick.cli").toggle({ name = "claude", focus = true })
			end,
			mode = { "n", "x", "i" },
			desc = "Sidekick Toggle Claude",
		},
		{
			"<c-e>",
			"<c-\\><c-n>",
			mode = { "t" },
			desc = "Exit terminal mode to normal mode",
		},
	},
}
