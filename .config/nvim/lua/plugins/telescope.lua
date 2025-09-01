return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"debugloop/telescope-undo.nvim",
		-- "ecthelionvi/NeoComposer.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		{ "nvim-telescope/telescope-live-grep-args.nvim", version = "^1.0.0" },
	},
	config = function()
		local tel = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local extensions = tel.extensions
		local lga_actions = require("telescope-live-grep-args.actions")

		tel.setup({
			extensions = {
				live_grep_args = {
					auto_quoting = true, -- enable/disable auto-quoting
					-- define mappings, e.g.
					mappings = { -- extend mappings
						i = {
							["<C-k>"] = lga_actions.quote_prompt(),
							["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
						},
					},
				},
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				},
			},
			defaults = {
				path_display = { "truncate" },
				preview = false,
				mappings = {
					i = {
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
				file_ignore_patterns = { "node_modules", "bun.lock" },
			},
		})

		vim.keymap.set("n", "<leader>k", builtin.find_files, {})
		-- vim.keymap.set("n", "<leader>j", extensions.live_grep_args.live_grep_args, {})
		vim.keymap.set("n", "<leader>j", builtin.live_grep, {})
		vim.keymap.set("n", "<leader>l", function()
			builtin.live_grep({ grep_open_files = true })
		end, {})
		vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, {})
		vim.keymap.set("n", "<leader>d", builtin.diagnostics, {})
		vim.keymap.set("n", "gb", builtin.buffers, {})
		vim.keymap.set("n", "gt", builtin.help_tags, {})

		vim.keymap.set("n", "gh", function()
			builtin.oldfiles({
				only_cwd = true,
			})
		end, {})

		vim.keymap.set("n", "gu", "<cmd>Telescope undo<cr>")
		-- vim.keymap.set("n", "gm", "<cmd>Telescope macros<cr>")

		-- chatgpt (c)
		local function grep_in_oil_dir()
			local oil_path = vim.fn.expand("%")
			if not oil_path:match("^oil://") then
				print("Not in an Oil directory")
				return
			end

			local local_path = oil_path:gsub("^oil://", "")

			extensions.live_grep_args.live_grep_args({ cwd = local_path })
		end

		vim.keymap.set("n", "<leader>i", grep_in_oil_dir) -- Set <leader>i to grep in Oil directory

		tel.load_extension("undo")
		tel.load_extension("fzf")
		tel.load_extension("live_grep_args")
		-- tel.load_extension('macros')
	end,
}
