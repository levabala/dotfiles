return {
	"mhartington/formatter.nvim",
	init = function()
		local util = require "formatter.util"
		local defaults = require "formatter.defaults"

		local prettierd = function()
			return {
				exe = "prettierd",
				args = { util.escape_path(util.get_current_buffer_file_path()) },
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

		require("formatter").setup({
			logging = true,
			log_level = vim.log.levels.WARN,
			filetype = {
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
			},
		})

		vim.keymap.set("n", "<leader>f", ":Format<CR>", { silent = true })
	end,
}
