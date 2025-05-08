return {
	{ -- Main Telescope plugin spec
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x", -- Recommended stable branch
		cmd = "Telescope", -- Lazy-load until :Telescope command is used
		dependencies = {
			"nvim-lua/plenary.nvim", -- Required
			{
				"nvim-telescope/telescope-fzf-native.nvim", -- Greatly speeds up sorting
				build = "make", -- Requires make and a C compiler
				cond = function()
					return vim.fn.executable("make") == 1
				end, -- Build only if 'make' is available
			},
			{ "nvim-telescope/telescope-ui-select.nvim" }, -- Uses Telescope for vim.ui.select
		},
		-- Global keymaps for Telescope pickers
		keys = {
			{
				"<leader>f",
				function()
					require("telescope.builtin").find_files({
						prompt_title = " Find Files",
						find_command = {
							"fd",
							"--type",
							"f",
							"--color",
							"never",
							"--hidden",
							"--no-ignore-vcs",
							"--follow",
						},
					})
				end,
				desc = "Find Files (fd, hidden, no-ignore-vcs, follow)",
			},
			{
				"<leader>F",
				function()
					require("telescope.builtin").find_files({
						prompt_title = " Find All Files",
						no_ignore = true,
						hidden = true,
					})
				end,
				desc = "Find ALL Files (no ignore, hidden)",
			},
			{
				"<leader>g",
				function()
					require("telescope.builtin").live_grep({ prompt_title = "grep Live Grep" })
				end,
				desc = "Live Grep (Project)",
			},
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers({
						prompt_title = "Buffers",
						sort_mru = true,
						ignore_current_buffer = true,
					})
				end,
				desc = "Find Buffers (MRU sorted)",
			},
			{
				"<leader>/",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find({
						prompt_title = " Find in Current Buffer",
					})
				end,
				desc = "Find in Current Buffer",
			},
			{
				"<leader>O",
				function()
					require("telescope.builtin").oldfiles({ prompt_title = " Old Files" })
				end,
				desc = "Find Old Files (Recent)",
			},
			{
				"<leader>?",
				function()
					require("telescope.builtin").help_tags({ prompt_title = "󰋗 Help Tags" })
				end,
				desc = "Find Help Tags",
			},
			{
				"<leader>d",
				function()
					require("telescope.builtin").diagnostics({ prompt_title = "󰒡 Diagnostics" })
				end,
				desc = "Workspace Diagnostics",
			},
			{
				"<leader>k",
				function()
					require("telescope.builtin").keymaps({ prompt_title = " Keymaps" })
				end,
				desc = "Search Keymaps",
			},
			{
				"<leader>C",
				function()
					require("telescope.builtin").commands({ prompt_title = " Commands" })
				end,
				desc = "Search Commands",
			},
			{
				"<leader>gc",
				function()
					require("telescope.builtin").git_commits({ prompt_title = " フ Git Commits" })
				end,
				desc = "Git Commits",
			},
			{
				"<leader>gs",
				function()
					require("telescope.builtin").git_status({ prompt_title = "󰊢 Git Status" })
				end,
				desc = "Git Status",
			},
			{
				"<leader>gb",
				function()
					require("telescope.builtin").git_branches({ prompt_title = " Git Branches" })
				end,
				desc = "Git Branches",
			},
			{
				"<leader>gl",
				function()
					require("telescope.builtin").git_bcommits({ prompt_title = " フ Git Buffer Commits" })
				end,
				desc = "Git Buffer Commits",
			},
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			-- local themes = require("telescope.themes") -- Not strictly needed if pickers use defaults

			telescope.setup({
				defaults = {
					-- === New Layout: Vertical with Results on Top, Preview Below ===
					layout_strategy = "horizontal",
					layout_config = {
						horizontal = {
							prompt_position = "top",
							preview_width = 0.65, -- <<< Giữ NGUYÊN preview rộng 65%
							mirror = false,
						},
						vertical = {
							prompt_position = "top", -- Prompt above results list
							preview_height = 0.5, -- Preview takes 50% of Telescope window height

							mirror = false, -- IMPORTANT: false = results on top, preview on bottom
						},
						-- General window sizing
						width = 0.75, -- Telescope window width (90% of editor)
						height = 0.70, -- Telescope window height (90% of editor)
					},

					-- === Appearance & Behavior ===
					path_display = { "smart" }, -- Smarter path display
					prompt_prefix = "  ", -- Nerd Font search icon
					selection_caret = " ", -- Nerd Font selection caret
					sorting_strategy = "ascending",
					border = true, -- Enable borders
					borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }, -- Rounded border characters

					-- === Mappings (inside Telescope window) ===
					mappings = {
						i = { -- Insert mode
							["<C-j>"] = actions.move_selection_next,
							["<C-k>"] = actions.move_selection_previous,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
							["<Esc>"] = actions.close,
							["<CR>"] = actions.select_default,
							["<C-s>"] = actions.select_horizontal, -- Open in horizontal split
							["<C-v>"] = actions.select_vertical, -- Open in vertical split
							["<C-t>"] = actions.select_tab, -- Open in new tab
						},
						n = { -- Normal mode (inside Telescope results)
							["j"] = actions.move_selection_next,
							["k"] = actions.move_selection_previous,
							["q"] = actions.close,
							["<CR>"] = actions.select_default,
							["<C-s>"] = actions.select_horizontal,
							["<C-v>"] = actions.select_vertical,
							["<C-t>"] = actions.select_tab,
							["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},

					file_ignore_patterns = {
						"node_modules",
						"%.git/",
						"%.cache",
						"build/",
						"dist/",
						"vendor/",
						"target/",
					},
				},

				-- Pickers configuration:
				-- We will let most pickers inherit the new vertical layout from defaults.
				-- If a specific picker needs a different theme/layout, it can be configured here.
				-- For now, keeping it minimal lets the defaults apply.
				pickers = {
					-- Example: If you want 'help_tags' to use a different layout:
					-- help_tags = { layout_strategy = "cursor", layout_config = { width = 0.7, height = 0.6 } },
					buffers = { sort_mru = true, ignore_current_buffer = true, previewer = true }, -- Keep specific options for buffers
					-- Other pickers will use the default vertical layout
				},

				extensions = {
					fzf = { -- For telescope-fzf-native.nvim
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
					["ui-select"] = { -- For telescope-ui-select.nvim
						-- Use Telescope's default theming for vim.ui.select
						-- This will inherit our new vertical layout defaults
					},
				},
			})

			-- Load enabled extensions
			pcall(telescope.load_extension, "fzf")
			pcall(telescope.load_extension, "ui-select")
		end,
	},
}
