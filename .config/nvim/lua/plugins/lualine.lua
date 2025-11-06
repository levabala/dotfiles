return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "AndreM222/copilot-lualine", "phha/zenburn.nvim" },
	lazy = false,
	init = function()
		require("lualine").setup({
			options = {
				icons_enabled = false,
				-- theme = "auto",
				theme = "zenburn",
				component_separators = { left = "", right = "" },
				section_separators = { left = "", right = "" },
				disabled_filetypes = {
					statusline = {},
					winbar = {},
				},
				ignore_focus = {},
				always_divide_middle = true,
				globalstatus = true,
				refresh = {
					statusline = 1000,
					tabline = 1000,
					winbar = 1000,
				},
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = {},
				lualine_c = {
					{
						"filename",
						file_status = true,
						newfile_status = true,
						path = 1,
					},
					{
						function()
							return "ඞ"
						end,
						color = function()
							local status = require("sidekick.status").get()
							if status then
								return status.kind == "Error" and "DiagnosticError" or status.busy and "DiagnosticWarn" or "Special"
							end
						end,
						cond = function()
							local status = require("sidekick.status")
							return status.get() ~= nil
						end,
					},
				},
				lualine_x = {
					"diagnostics",
					{
						"copilot",
						symbols = {
							status = {
								icons = {
									enabled = "✓ ",
									sleep = "Zz ",
									disabled = "✗ ",
									warning = "! ",
									unknown = "? ",
								},
							},
						},
					},
				},
				lualine_y = { "progress" },
				lualine_z = { "location" },
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { "filename" },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline = {},
			winbar = {},
			inactive_winbar = {},
			extensions = {},
		})
	end,
}
