local function exists(path)
	return vim.loop.fs_stat(path) ~= nil
end

return {
	{ dir = "~/arcadia/devtools/vim/plugin_bundles/signify", cond = exists(vim.fn.expand("~/arcadia")) },
	{ dir = "~/arcadia/devtools/vim/plugin_bundles/vcscommand", cond = exists(vim.fn.expand("~/arcadia")) },
	enabled = false,
}
