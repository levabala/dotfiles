return {
	"Exafunction/windsurf.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		require("codeium").setup({
			virtual_text = {
				enabled = true,
				manual = true,
				-- How long to wait (in ms) before requesting completions after typing stops.
				idle_delay = 75,
				-- Disable default key bindings to set up custom ones
				key_bindings = {
					accept = "<C-l>",
					accept_word = false,
					accept_line = false,
					clear = false,
					next = "<M-]>",
					prev = "<M-[>",
				},
			},
			enable_cmp_source = false,
		})

		-- Track if Ctrl+K was pressed in current insert session
		local auto_enabled = false

		-- Set up Ctrl+K to manually trigger completions and enable auto-show
		vim.keymap.set("i", "<C-k>", function()
			auto_enabled = true
			require("codeium.virtual_text").complete()
		end, { desc = "Trigger Windsurf completion" })

		-- Reset auto-enabled when leaving insert mode
		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				auto_enabled = false
			end,
		})

		-- Override the debounced_complete to respect our auto_enabled flag
		vim.api.nvim_create_autocmd("TextChangedI", {
			callback = function()
				print("change")
				if auto_enabled then
					print("change enabled")
					require("codeium.virtual_text").debounced_complete()
				end
			end,
		})
	end,
	enabled = true,
}
