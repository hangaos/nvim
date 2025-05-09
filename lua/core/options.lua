-- ~/.config/nvim/lua/core/options.lua
-- File encoding
vim.opt.encoding = "utf-8" -- Set encoding to UTF-8 (important!)

-- UI Settings
vim.opt.number = true -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.termguicolors = true -- Enable true color support (essential for themes)
vim.opt.scrolloff = 8 -- Keep 8 lines visible above/below cursor when scrolling
vim.opt.signcolumn = "yes" -- Always show the sign column (prevents layout shifts)
vim.opt.showmatch = true -- Highlight matching brackets
vim.opt.showcmd = true -- Show command in the bottom right
vim.opt.showmode = false -- Show current mode (e.g., -- INSERT --)
vim.opt.wrap = false -- Do not wrap long lines
vim.opt.cursorline = true -- Highlight the current line

-- Indentation
vim.opt.expandtab = true -- Use spaces instead of tabs
vim.opt.shiftwidth = 2 -- Spaces for auto-indent (use 4 if you prefer)
vim.opt.tabstop = 2 -- Spaces for a tab character (use 4 if you prefer)
vim.opt.smartindent = true -- Enable smart indentation

-- Search Behavior
vim.opt.ignorecase = true -- Case-insensitive searching...
vim.opt.smartcase = true -- ...unless the pattern contains uppercase letters
vim.opt.hlsearch = true -- Highlight search results
vim.opt.incsearch = true -- Show results incrementally while typing

-- Behavior
vim.opt.mouse = "a" -- Enable mouse support in all modes
vim.opt.backspace = "indent,eol,start" -- Make backspace more flexible
vim.opt.undofile = true -- Enable persistent undo
vim.opt.updatetime = 250 -- Faster update time (for plugins like LSP)
vim.opt.timeoutlen = 300 -- Shorter timeout for key sequences (e.g., leader key)

-- Leader Key (Very Important!)
vim.g.mapleader = " " -- Set the leader key to Space
vim.g.maplocalleader = " " -- Set the local leader key to Space

-- Disable backup files
vim.opt.backup = false
vim.opt.writebackup = false

-- Others
vim.opt.cmdheight = 0

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Optional: Create undo directory if it doesn't exist
-- This helps keep your main config directory clean
local undodir_path = vim.fn.stdpath("data") .. "/undodir"
if vim.fn.isdirectory(undodir_path) == 0 then
	vim.fn.mkdir(undodir_path, "p")
end
vim.opt.undodir = undodir_path
