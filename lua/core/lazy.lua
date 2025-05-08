local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	print("Installing lazy.nvim...")
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath) -- Add lazy.nvim to the runtime path

require("lazy").setup("plugins", {
	-- Optional configuration options for lazy.nvim itself
	checker = {
		enabled = true, -- Automatically check for plugin updates
		notify = false, -- Don't notify on check, only on install/update
	},
	change_detection = {
		enabled = true,
		notify = false, -- Don't notify on file change detection
	},
})
