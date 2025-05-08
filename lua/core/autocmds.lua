local api = vim.api
local fn = vim.fn

local function augroup(name)
	return api.nvim_create_augroup("custom_augroup_" .. name, { clear = true })
end

-- =============================================================================
-- == General UI & Editor Behavior Autocommands ==
-- =============================================================================

api.nvim_create_autocmd("TextYankPost", {
	group = augroup("HighlightYank"),
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 300 })
	end,
	desc = "Highlight selection on yank",
})

api.nvim_create_autocmd("BufReadPost", {
	group = augroup("RememberCursorPosition"),
	pattern = "*",
	callback = function(args)
		if fn.line("'\"") > 1 and fn.line("'\"") <= fn.line("$") and not vim.bo[args.buf].readonly then
			api.nvim_win_set_cursor(0, { fn.line("'\""), fn.col("'\"") - 1 })
		end
	end,
	desc = "Restore cursor position on opening a file",
})

api.nvim_create_autocmd("FileType", {
	group = augroup("CloseWithQ"),
	pattern = {
		"help",
		"man",
		"qf",
		"Trouble",
		"lazy",
		"mason",
		"alpha",
	},
	callback = function(args)
		vim.bo[args.buf].buflisted = false
		api.nvim_buf_set_keymap(args.buf, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true, nowait = true })
	end,
	desc = "Set 'q' to close specific buffer types",
})

api.nvim_create_autocmd("OptionSet", {
	group = augroup("CenteredScroll"),
	pattern = "scroll",
	callback = function()
		vim.opt.scrolloff = 999
	end,
	desc = "Keep cursor centered vertically on scroll (scrolloff=999)",
})

api.nvim_create_autocmd("VimResized", {
	group = augroup("AutoResizeSplits"),
	pattern = "*",
	command = "wincmd =",
	desc = "Auto resize splits on VimResized event",
})

-- =============================================================================
-- == Filetype Specific Autocommands ==
-- =============================================================================

api.nvim_create_autocmd("FileType", {
	group = augroup("FiletypeIndent"),
	pattern = "make",
	callback = function(args)
		vim.bo[args.buf].expandtab = false
		vim.bo[args.buf].shiftwidth = 4
		vim.bo[args.buf].tabstop = 4
	end,
	desc = "Use tabs for Makefiles",
})

api.nvim_create_autocmd("BufWritePre", {
	group = augroup("AutoCreateDirs"),
	pattern = "*",
	callback = function(args)
		local file = api.nvim_buf_get_name(args.buf)
		local dir = fn.fnamemodify(file, ":h")
		if file ~= "" and dir ~= "" and fn.isdirectory(dir) == 0 then
			fn.mkdir(dir, "p")
			vim.notify("Created directory: " .. dir, vim.log.levels.INFO)
		end
	end,
	desc = "Auto create parent directories on save",
})

-- =============================================================================
-- == LSP & Development Autocommands ==
-- =============================================================================

api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
	group = augroup("AutoRead"),
	pattern = "*",
	callback = function()
		if vim.bo.autoread and not vim.bo.modified then
			vim.cmd("checktime")
		end
	end,
	desc = "Auto reload buffer if changed on disk and not modified locally",
})

-- =============================================================================
-- == Other Useful Autocommands ==
-- =============================================================================

api.nvim_create_autocmd("FileType", {
	group = augroup("GitCommitCursor"),
	pattern = "gitcommit",
	callback = function()
		api.nvim_win_set_cursor(0, { 7, 0 })
	end,
	desc = "Jump to line 7 for git commit messages",
})

api.nvim_create_autocmd("BufWritePre", {
	group = augroup("TrimWhitespace"),
	pattern = { "*.lua", "*.py", "*.js", "*.ts", "*.java", "*.c", "*.cpp", "*.go", "*.html", "*.css", "*.md" },
	callback = function()
		local current_win = api.nvim_get_current_win()
		local current_cursor = api.nvim_win_get_cursor(current_win)
		local current_view = fn.winsaveview()
		vim.cmd([[silent! %s/\s\+$//e]])
		fn.winrestview(current_view)
		api.nvim_win_set_cursor(current_win, current_cursor)
	end,
	desc = "Remove trailing whitespace on save",
})
