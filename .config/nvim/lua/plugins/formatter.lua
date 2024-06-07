return {
	"mhartington/formatter.nvim",
	init = function()
		local util = require("formatter.util")

		local prettierd = function()
			return {
				exe = "prettierd",
				args = { vim.api.nvim_buf_get_name(0) },
				stdin = true,
			}
		end

		local gofumpt = function()
			return {
				exe = "gofumpt",
				args = { util.escape_path(util.get_current_buffer_file_path()) },
				stdin = true,
			}
		end

		local racofmt = function()
			return {
				exe = "raco fmt",
				args = { util.escape_path(util.get_current_buffer_file_path()) },
				stdin = true,
			}
		end

		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
				rust = {
					require("formatter.filetypes.rust").rustfmt,
				},
				lua = {
					require("formatter.filetypes.lua").stylua,
				},
				javascript = {
					prettierd,
				},
				typescript = {
					prettierd,
				},
				typescriptreact = {
					prettierd,
				},
				html = {
					prettierd,
				},
				css = {
					prettierd,
				},
				scss = {
					prettierd,
				},
				astro = {
					require("formatter.filetypes.javascriptreact").prettier,
				},
				go = {
					gofumpt,
				},
				json = {
					prettierd,
				},
				racket = {
					racofmt,
				},
			},
		})

		vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })
	end,
}
