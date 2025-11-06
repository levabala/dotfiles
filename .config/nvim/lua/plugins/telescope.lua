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
				-- file_ignore_patterns = { "node_modules", "bun.lock" },
			},
		})

		-- Progressive path folding - fold segments one by one from start
		local function progressive_fold_path(path, max_width)
			if #path <= max_width then
				return path
			end

			local segments = {}
			for segment in path:gmatch("[^/]+") do
				table.insert(segments, segment)
			end

			-- Don't fold if only one segment (just filename)
			if #segments <= 1 then
				return path
			end

			-- Try folding segments one by one from the start
			for fold_count = 1, #segments - 1 do -- never fold the last segment (filename)
				local folded_path = ""
				for i, segment in ipairs(segments) do
					if i <= fold_count then
						folded_path = folded_path .. segment:sub(1, 1) .. "/"
					else
						folded_path = folded_path .. segment
						if i < #segments then
							folded_path = folded_path .. "/"
						end
					end
				end

				if #folded_path <= max_width then
					return folded_path
				end
			end

			-- If still too long, fold all but last segment
			local result = ""
			for i, segment in ipairs(segments) do
				if i < #segments then
					result = result .. segment:sub(1, 1) .. "/"
				else
					result = result .. segment
				end
			end
			return result
		end

		-- Helper function to get visual selection
		local function get_visual_selection()
			local start_pos = vim.fn.getpos("'<")
			local end_pos = vim.fn.getpos("'>")
			
			-- If we have a valid visual selection (marks are set and different)
			if start_pos[2] ~= 0 and end_pos[2] ~= 0 and (start_pos[2] ~= end_pos[2] or start_pos[3] ~= end_pos[3]) then
				local lines = vim.fn.getline(start_pos[2], end_pos[2])
				
				if #lines == 1 then
					return string.sub(lines[1], start_pos[3], end_pos[3])
				else
					-- For multi-line selections, join with spaces for search
					return table.concat(lines, " ")
				end
			end
			return nil
		end

		vim.keymap.set("n", "<leader>k", builtin.find_files, {})
		-- vim.keymap.set("n", "<leader>j", extensions.live_grep_args.live_grep_args, {})
		
		vim.keymap.set("n", "<leader>j", function()
			builtin.live_grep()
		end, {})
		
		vim.keymap.set("v", "<leader>j", function()
			-- Exit visual mode first to set the '< and '> marks
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
			local selection = get_visual_selection()
			if selection then
				builtin.live_grep({ default_text = selection })
			else
				builtin.live_grep()
			end
		end, {})
		
		vim.keymap.set("n", "<leader>l", function()
			local cwd = vim.fn.getcwd()
			local oldfiles = vim.v.oldfiles
			local files = {}
			for _, file in ipairs(oldfiles) do
				if vim.startswith(file, cwd) then
					table.insert(files, file)
				end
			end
			
			local grep_opts = {}
			
			if #files > 0 then
				grep_opts.search_dirs = files
				builtin.live_grep(grep_opts)
			else
				grep_opts.cwd = cwd
				builtin.live_grep(grep_opts)
			end
		end, {})
		
		vim.keymap.set("v", "<leader>l", function()
			-- Exit visual mode first to set the '< and '> marks
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
			local cwd = vim.fn.getcwd()
			local oldfiles = vim.v.oldfiles
			local files = {}
			for _, file in ipairs(oldfiles) do
				if vim.startswith(file, cwd) then
					table.insert(files, file)
				end
			end
			
			local selection = get_visual_selection()
			local grep_opts = selection and { default_text = selection } or {}
			
			if #files > 0 then
				grep_opts.search_dirs = files
				builtin.live_grep(grep_opts)
			else
				grep_opts.cwd = cwd
				builtin.live_grep(grep_opts)
			end
		end, {})
		vim.keymap.set("n", "<leader>s", builtin.lsp_document_symbols, {})
		vim.keymap.set("n", "<leader>d", builtin.diagnostics, {})
		vim.keymap.set("n", "gb", builtin.buffers, {})
		vim.keymap.set("n", "gt", builtin.help_tags, {})

		vim.keymap.set("n", "gh", function()
			local make_entry = require("telescope.make_entry")

			builtin.oldfiles({
				only_cwd = true,
				entry_maker = function(line)
					local entry = make_entry.gen_from_file({})(line)
					if not entry then
						return nil
					end

					-- Calculate available width for path
					local win_width = vim.o.columns
					local telescope_width = math.floor(win_width * 0.8)
					local max_path_width = math.floor(telescope_width * 0.8)

					-- Get relative path from cwd
					local cwd = vim.fn.getcwd()
					local display_path = entry.value
					if vim.startswith(display_path, cwd) then
						display_path = display_path:sub(#cwd + 2) -- +2 to remove the leading slash
					end

					local shortened_path = progressive_fold_path(display_path, max_path_width)

					entry.display = shortened_path
					entry.ordinal = display_path

					return entry
				end,
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

		-- Zoekt search with optional prefill from visual selection
		local function zoekt_search(use_selection)
			local pickers = require("telescope.pickers")
			local finders = require("telescope.finders")
			local conf = require("telescope.config").values

			local max_results = 100000 -- Limit search results
			
			-- Only get visual selection if explicitly requested
			local selection = use_selection and get_visual_selection() or nil
			
			local picker_opts = {
				prompt_title = "Zoekt Live Search",
				finder = finders.new_async_job({
					command_generator = function(prompt)
						if not prompt or prompt == "" then
							return nil
						end
						-- Escape regex special characters for zoekt
						local escaped_prompt = prompt
							:gsub("%(", "\\(")
							:gsub("%)", "\\)")
							:gsub("%[", "\\[")
							:gsub("%]", "\\]")
							:gsub("%{", "\\{")
							:gsub("%}", "\\}")
							:gsub("%.", "\\.")
							:gsub("%*", "\\*")
							:gsub("%+", "\\+")
							:gsub("%?", "\\?")
							:gsub("%^", "\\^")
							:gsub("%$", "\\$")
							:gsub("%|", "\\|")
						
						return {
							"sh",
							"-c",
							"zoekt " .. vim.fn.shellescape(escaped_prompt) .. " | head -n " .. tostring(max_results),
						}
					end,
					entry_maker = function(line)
						-- Parse zoekt output format: filename:linenumber:content
						local filename, lnum, content = line:match("^([^:]+):(%d+):(.*)$")
						if not filename or not lnum or not content then
							return nil
						end

						-- Get actual window width and calculate available space for path (use 60% of telescope width)
						local win_width = vim.o.columns
						local telescope_width = math.floor(win_width * 0.8) -- telescope uses ~80% of screen
						local available_width = math.floor(telescope_width * 0.6) -- use 60% of telescope width for path
						local line_num_width = #tostring(lnum) + 1 -- +1 for colon
						local max_path_width = math.max(20, available_width - line_num_width - 5) -- -5 for margins

						local shortened_path = progressive_fold_path(filename, max_path_width)
						local display_line = shortened_path .. ":" .. lnum .. ":" .. content

						return {
							value = line,
							display = display_line,
							ordinal = filename .. " " .. content,
							filename = filename,
							lnum = tonumber(lnum),
							col = 1,
							text = content,
						}
					end,
					cwd = vim.fn.getcwd(),
				}),
				sorter = conf.generic_sorter({}),
				previewer = conf.grep_previewer({}),
				cache_picker = {
					num_pickers = 1,
					limit_entries = 1000,
				},
				selection_strategy = "reset",
				-- sorting_strategy = "ascending",
				scroll_strategy = "cycle",
			}
			
			-- Only add default_text if we have a selection
			if selection then
				picker_opts.default_text = selection
			end

			pickers.new({}, picker_opts):find()
		end

		vim.keymap.set("n", "<leader>z", function() zoekt_search(false) end, { desc = "Zoekt search" })
		vim.keymap.set("v", "<leader>z", function()
			-- Exit visual mode first to set the '< and '> marks
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "nx", false)
			zoekt_search(true)
		end, { desc = "Zoekt search with selection" })

		tel.load_extension("undo")
		tel.load_extension("fzf")
		tel.load_extension("live_grep_args")
		-- tel.load_extension('macros')
	end,
}
