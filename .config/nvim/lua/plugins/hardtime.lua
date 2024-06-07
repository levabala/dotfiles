return {
	"takac/vim-hardtime",
	init = function()
		vim.g.hardtime_default_on = 1
		vim.g.hardtime_allow_different_key = 1
		vim.g.hardtime_maxcount = 3
		vim.g.hardtime_motion_with_count_resets = 1
		vim.g.hardtime_ignore_quickfix = 1
		vim.g.hardtime_ignore_buffer_patterns = { "oil.*" }
		vim.g.hardtime_showmsg = 1
	end,
	enabled = false,
}
