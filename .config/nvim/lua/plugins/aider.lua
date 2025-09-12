return {
	"nekowasabi/aider.vim",
	dependencies = "vim-denops/denops.vim",
	init = function()
		vim.g.aider_command = 'aider --model deepseek --read ./AIDER.md --load AIDER_STARTUP_COMMANDS.txt --dark-mode --code-theme monokai --test-cmd \'parallel --tty --jobs 2 --keep-order ::: "tsc --noEmit -p ./tsconfig.json" "bun lint" && bun test\' --auto-test'
		vim.g.aider_buffer_open_type = "floating"
		vim.g.aider_floatwin_width = 130
		vim.g.aider_floatwin_height = 33

		vim.api.nvim_create_autocmd("User", {
			pattern = "AiderOpen",
			callback = function(args)
				vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { buffer = args.buf })
				vim.keymap.set("n", "q", "<cmd>AiderHide<CR>", { buffer = args.buf })
			end,
		})
		vim.api.nvim_set_keymap("n", "<leader>at", ":AiderRun<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>aT", ":let g:aider_command = 'aider --no-auto-commit --vim --model deepseek --map-tokens 0  --dark-mode --code-theme monokai --no-git  --input-history-file /Users/levabala/.aider.input.history.arc --chat-history-file /Users/levabala/.aider.chat.history.md.arc --llm-history-file /Users/levabala/.aider.llm.history.arc --read AIDER.md'<CR>:AiderRun<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>aA", ":AiderAddCurrentFile<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>aa", ":AiderSilentAddCurrentFile<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ab", ":AiderAddBuffers<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap(
			"n",
			"<leader>ar",
			":AiderAddCurrentFileReadOnly<CR>",
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap("n", "<leader>aw", ":AiderAddWeb<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ax", ":AiderExit<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ai", ":AiderAddIgnoreCurrentFile<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>aI", ":AiderOpenIgnore<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>aI", ":AiderPaste<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("n", "<leader>ah", ":AiderHide<CR>", { noremap = true, silent = true })
		vim.api.nvim_set_keymap("v", "<leader>av", ":AiderVisualTextWithPrompt<CR>", { noremap = true, silent = true })
	end,
	enabled = false,
	lazy = false,
}
