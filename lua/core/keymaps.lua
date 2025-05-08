local map = vim.keymap.set -- Use vim.keymap.set for brevity
local function keymap_opts(description) -- <<< THÊM HÀM NÀY VÀO
	return { noremap = true, silent = true, desc = description }
end
-- Define options for mappings
-- noremap = true: non-recursive mapping
-- silent = true: don't echo the command in the command line
local opts = { noremap = true, silent = true }

-- =============================================================================
-- == Normal Mode Mappings ==
-- =============================================================================

-- Select All (Cmd + A)
-- gg: go to first line
-- V: start visual line mode
-- G: go to last line
map("n", "<D-a>", "ggVG", { noremap = true, silent = true, desc = "Select All" }) -- Added desc

-- Undo/Redo (macOS like, optional)
map("n", "<D-z>", "<Cmd>undo<CR>", { silent = true, noremap = true, desc = "Undo" })
map("n", "<D-S-z>", "<Cmd>redo<CR>", { silent = true, noremap = true, desc = "Redo" })


-- Neo-Tree Keymaps
map(
	"n",
	"<leader>t",
	"<cmd>Neotree filesystem toggle left<CR>",
	{ desc = "Toggle Neo-tree (Filesystem)", silent = true, noremap = true }
)
-- Refresh Neo-tree (filesystem source)
map(
	"n",
	"<leader>r",
	"<cmd>Neotree filesystem refresh<CR>",
	{ desc = "Refresh Neo-tree", silent = true, noremap = true }
)
-- Reveal current file in Neo-tree (filesystem source, on the left)
map(
	"n",
	"<leader>fe",
	"<cmd>Neotree filesystem reveal left<CR>",
	{ desc = "Neo-tree Reveal File", silent = true, noremap = true }
)
-- Focus Neo-tree window
map("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Neo-tree Focus", silent = true, noremap = true })


-- =============================================================================
-- == Insert Mode Mappings ==
-- =============================================================================
-- Add Insert mode mappings here later
-- Example: map('i', 'jj', '<Esc>', opts)

-- =============================================================================
-- == Visual Mode Mappings ==
-- =============================================================================
-- Add Visual mode mappings here later
-- Example: map('v', '<', '<gv', opts)
-- Example: map('v', '>', '>gv', opts)

