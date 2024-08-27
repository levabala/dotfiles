return {
	"VonHeikemen/lsp-zero.nvim",
	branch = "v3.x",
	dependencies = {
		-- LSP Support
		{ "neovim/nvim-lspconfig" },
		{ "williamboman/mason.nvim" },
		{ "williamboman/mason-lspconfig.nvim" },

		-- Autocompletion
		{ "hrsh7th/nvim-cmp" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-path" },
		{ "saadparwaiz1/cmp_luasnip" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-nvim-lua" },
		{ "lukas-reineke/cmp-under-comparator" },

		-- Snippets
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },
	},
	init = function()
		local lsp = require("lsp-zero")

		lsp.preset("recommended")

		local cmp = require("cmp")
		local cmp_select = { behavior = cmp.SelectBehavior.Replace }
		local cmp_mappings = lsp.defaults.cmp_mappings({
			["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
			["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
			["<C-l>"] = cmp.mapping.confirm({ select = true }),
			["<CR>"] = cmp.mapping.confirm({ select = true }),
			["<C-Space>"] = cmp.mapping.complete(),
		})

		cmp.setup({
			sources = {
				{ name = "nvim_lsp" },
				{ name = "nvim_lua" },
				{ name = "luasnip" },
				{ name = "path" },
				{ name = "buffer" },
			},
			mapping = cmp_mappings,
			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					require("cmp-under-comparator").under,
					cmp.config.compare.kind,
					cmp.config.compare.sort_text,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
			},
			preselect = "none",
			completion = {
				completeopt = "menu,menuone,noinsert,noselect",
			},
		})

		lsp.set_preferences({
			sign_icons = {
				error = "E",
				warn = "W",
				hint = "H",
				info = "I",
			},
		})

		local function filter(arr, fn)
			if type(arr) ~= "table" then
				return arr
			end

			local filtered = {}
			for k, v in pairs(arr) do
				if fn(v, k, arr) then
					table.insert(filtered, v)
				end
			end

			return filtered
		end

		local function filterNodeModules(value)
			return string.match(value.filename, "node_modules") == nil
		end

		local function filterNotAutoImport(value)
			return string.match(value.filename, "Add import") ~= nil
		end

		local function on_list(options, filterFunc, forceOpen)
			local items = options.items
			if #items > 1 then
				items = filter(items, filterFunc)
			end

			vim.fn.setqflist({}, " ", { title = options.title, items = items, context = options.context })

			local command = (#items > 1 or forceOpen) and "botright cwindow" or "cfirst"
			vim.api.nvim_command(command)
		end

		local function on_list_node_modules(options)
			return on_list(options, filterNodeModules)
		end

		local function on_list_not_auto_import(options)
			return on_list(options, filterNotAutoImport, true)
		end

		lsp.on_attach(function(client, bufnr)
			local opts = { buffer = bufnr, remap = false }

			vim.keymap.set("n", "gD", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gd", function()
				vim.lsp.buf.definition({ on_list = on_list_node_modules })
			end, opts)
			vim.keymap.set("n", "K", function()
				vim.lsp.buf.hover()
			end, opts)
			-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
			vim.keymap.set("n", "<leader>e", function()
				vim.diagnostic.open_float({ focusable = true })
			end, opts)
			vim.keymap.set("n", "[D", function()
				vim.diagnostic.goto_next()
			end, opts)
			vim.keymap.set("n", "]D", function()
				vim.diagnostic.goto_prev()
			end, opts)
			vim.keymap.set("n", "[d", function()
				vim.diagnostic.goto_next({
					severity = vim.diagnostic.severity.ERROR,
				})
			end, opts)
			vim.keymap.set("n", "]d", function()
				vim.diagnostic.goto_prev({
					severity = vim.diagnostic.severity.ERROR,
				})
			end, opts)
			vim.keymap.set("n", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("v", "<leader>ca", function()
				vim.lsp.buf.code_action()
			end, opts)
			vim.keymap.set("n", "<space>ci", function()
				vim.lsp.buf.code_action({ on_list = on_list_not_auto_import })
			end, bufopts)
			vim.keymap.set("n", "gr", function()
				vim.lsp.buf.references()
			end, opts)
			vim.keymap.set("n", "<leader>rn", function()
				vim.lsp.buf.rename()
			end, opts)
			vim.keymap.set("i", "<C-h>", function()
				vim.lsp.buf.signature_help()
			end, opts)
		end)

		require("mason").setup({})
		require("mason-lspconfig").setup({
			ensure_installed = {},
			handlers = {
				function(server_name)
					require("lspconfig")[server_name].setup({})
				end,

				-- ts is handled by typescript-tools plugin
				tsserver = lsp.noop,

				stylelint_lsp = function()
					require("lspconfig").stylelint_lsp.setup({
						filetypes = { "css", "scss" },
					})
				end,
			},
		})

		-- snippets
		local ls = require("luasnip")

		vim.keymap.set({ "i" }, "<C-K>", function()
			ls.expand()
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-L>", function()
			ls.jump(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-J>", function()
			ls.jump(-1)
		end, { silent = true })

		vim.keymap.set({ "i", "s" }, "<C-E>", function()
			if ls.choice_active() then
				ls.change_choice(1)
			end
		end, { silent = true })

		require("typescript-tools").setup({
			settings = {
			},
		})
	end,
}
