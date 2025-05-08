return {
	"lewis6991/gitsigns.nvim",
	event = { "BufReadPre", "BufNewFile" }, -- Load early for timely sign display
	opts = {
		signs = {
			add = { text = "+" },
			change = { text = "~" },
			delete = { text = "-" },
			topdelete = { text = "‾" },
			changedelete = { text = "~" },
			untracked = { text = "┆" },
		},
		signcolumn = true, -- Ensure signcolumn is always visible
		numhl = true, -- Highlight line number with sign color
		linehl = false, -- Do not highlight the whole line
		word_diff = false, -- Disable word diff for performance

		current_line_blame = false, -- Default to false, toggle with keymap
		current_line_blame_opts = {
			virt_text = true,
			virt_text_pos = "eol", -- Position of the virtual text: 'eol', 'overlay', 'right_align'
			delay = 500, -- Delay in milliseconds before showing blame
			ignore_whitespace = false,
		},
		current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>", -- Customize blame message format

		-- update_debounce = 100, -- How often to update signs, default is 100
		-- status_formatter = nil, -- Disable gitsigns own statusline component if Lualine handles it

		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns
			-- Helper for buffer-local keymaps
			local function map_buf(mode, lhs, rhs, desc)
				vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, noremap = true, silent = true, desc = desc })
			end

			-- Navigation
			map_buf("n", "]h", function()
				if vim.wo.diff then
					return "]c"
				end -- Use Neovim's built-in diff navigation if in diff mode
				vim.schedule(function()
					gs.next_hunk()
				end)
				return "<Ignore>"
			end, "Gitsigns: Next Hunk")

			map_buf("n", "[h", function()
				if vim.wo.diff then
					return "[c"
				end -- Use Neovim's built-in diff navigation if in diff mode
				vim.schedule(function()
					gs.prev_hunk()
				end)
				return "<Ignore>"
			end, "Gitsigns: Previous Hunk")

			-- Actions
			map_buf({ "n", "v" }, "<leader>hs", gs.stage_hunk, "Gitsigns: Stage Hunk")
			map_buf({ "n", "v" }, "<leader>hr", gs.reset_hunk, "Gitsigns: Reset Hunk")
			map_buf("n", "<leader>hu", gs.undo_stage_hunk, "Gitsigns: Undo Stage Hunk")
			map_buf("n", "<leader>hp", gs.preview_hunk, "Gitsigns: Preview Hunk")
			map_buf("n", "<leader>hb", function()
				gs.blame_line({ full = true })
			end, "Gitsigns: Blame Line (Full)")
			map_buf("n", "<leader>hD", function()
				gs.diffthis("~")
			end, "Gitsigns: Diff This ~ (vs HEAD)")
			map_buf("n", "<leader>hd", gs.diffthis, "Gitsigns: Diff This (vs Index/Staged)")
			map_buf("n", "<leader>ht", gs.toggle_current_line_blame, "Gitsigns: Toggle Line Blame")

			-- Text Object
			-- These allow operations like 'dih' (delete inner hunk) or 'vah' (visually select a hunk)
			map_buf({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns: Select Inner Hunk")
			map_buf(
				{ "o", "x" },
				"ah",
				":<C-U>Gitsigns select_hunk<CR>",
				"Gitsigns: Select A Hunk (same as inner for now)"
			)
		end,
	},
}
