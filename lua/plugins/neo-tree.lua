return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x", -- Recommended stable branch
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- For icons
		"MunifTanjim/nui.nvim", -- For UI components
		-- Optional: For image previews if you want them later
		-- "3rd/image.nvim",
		-- Optional: For better integration with git status if not using default
		-- "s1n7ax/nvim-window-picker" -- If using window_picker for open_split/vsplit actions
	},
	cmd = "Neotree", 
	opts = {
		-- General options
		close_if_last_window = false, -- Default: false. Set to true to close Neovim if it's the last window.
		popup_border_style = "rounded", -- Border style for popups: "rounded", "double", "single", "shadow", "none"
		enable_git_status = true, -- Show git status indicators
		enable_diagnostics = true, -- Show LSP diagnostics indicators (errors, warnings)
		enable_modified_markers = true, -- Show '●' for modified buffers in the buffer list source
		enable_opened_markers = true, -- Show a marker for currently open files in the tree

		-- How to handle opening files
		open_files_do_not_replace_types = { "terminal", "trouble", "qf" }, -- Filetypes that won't be replaced

		-- Default component configurations (can be overridden per source)
		default_component_configs = {
			container = {
				enable_character_fade = true, -- Fade out long names
			},
			indent = {
				indent_size = 2,
				padding = 1, -- Padding before the first indent marker
				with_expanders = true, -- Show expander icons (requires Nerd Font for default icons)
				expander_collapsed = "", -- Collapsed folder icon
				expander_expanded = "", -- Expanded folder icon
				expander_highlight = "NeoTreeExpander",
				with_indent_markers = true, -- Show indent lines
				indent_marker = "│", -- Character for indent line
				last_indent_marker = "└", -- Character for last indent line
				highlight = "NeoTreeIndentMarker",
			},
			icon = {
				folder_closed = "", -- Nerd Font folder icon
				folder_open = "", -- Nerd Font open folder icon
				folder_empty = "", -- Nerd Font empty folder icon
				default = "󰈔", -- Default file icon (can be overridden by devicons)
				highlight = "NeoTreeFileIcon",
			},
			modified = {
				symbol = "● ", -- Symbol for modified files/buffers
				highlight = "NeoTreeModified",
			},
			name = {
				trailing_slash = false, -- Do not add a trailing slash to directory names
				use_git_status_colors = true, -- Color filenames based on git status
				highlight = "NeoTreeFileName",
			},
			git_status = {
				symbols = {
					-- Change type symbols
					added = "✚", -- Requires Nerd Font (e.g., Material Design Icons)
					deleted = "✖", -- Requires Nerd Font
					modified = "●", -- Requires Nerd Font
					renamed = "➜", -- Requires Nerd Font
					-- Status type symbols
					untracked = "U", -- Simpler text for untracked (or use ★)
					ignored = "◌",
					unstaged = "!",
					staged = "✓",
					conflict = "", -- Requires Nerd Font
				},
				align = "right", -- Position git status to the right of the filename
			},
			diagnostics = {
				symbols = { -- Requires Nerd Font
					hint = "",
					info = "",
					warn = "",
					error = "",
				},
				highlight = "NeoTreeDiagnosticError", -- And others like NeoTreeDiagnosticWarn, etc.
			},
		},

		-- Window settings (position, width, mappings within the tree)
		window = {
			position = "left",
			width = 35,
			mapping_options = {
				noremap = true,
				nowait = true,
			},
			mappings = {
				["<CR>"] = "open",
				["o"] = "open",
				["<esc>"] = "cancel", -- Close popups, search, etc. Does not close the tree.
				["q"] = "close_window", -- Key to close the Neo-tree window
				["P"] = { "toggle_preview", config = { use_float = true, width = 60, height = 25 } }, -- Floating preview
				["l"] = "focus_preview", -- Focus the preview window
				["S"] = "open_split", -- Open in horizontal split
				["s"] = "open_vsplit", -- Open in vertical split
				["t"] = "open_tabnew", -- Open in new tab
				["C"] = "close_node", -- Close current folder node
				["z"] = "close_all_nodes",
				["Z"] = "expand_all_nodes",
				["a"] = { "add", config = { show_path = "relative" } }, -- Add file/folder (relative path shown)
				["A"] = "add_directory",
				["d"] = "delete",
				["r"] = "rename",
				["y"] = "copy_to_clipboard",
				["x"] = "cut_to_clipboard",
				["p"] = "paste_from_clipboard",
				["c"] = "copy",
				["m"] = "move",
				["R"] = "refresh",
				["?"] = "show_help", -- Show Neo-tree's help popup
				["<"] = "prev_source", -- Cycle to previous source (filesystem, git_status, buffers)
				[">"] = "next_source", -- Cycle to next source
				["i"] = "show_file_details", -- Show details popup for the selected item
				-- Add any other custom mappings for inside the Neo-tree window here
			},
		},

		-- Filesystem source specific options
		filesystem = {
			filtered_items = {
				visible = false, -- Do not show hidden files by default
				hide_dotfiles = true, -- Hide files starting with a dot
				hide_gitignored = true, -- Hide files listed in .gitignore
				hide_hidden = true, -- Hide OS-level hidden files (if supported)
				-- always_show = { ".gitconfig", ".zshenv" }, -- Example: files to always show
				never_show = { ".DS_Store", "thumbs.db" }, -- Example: files to never show
			},
			follow_current_file = {
				enabled = true, -- Focus the path in the tree when changing buffers
				leave_dirs_open = false, -- Close directories when focus leaves them
			},
			group_empty_dirs = true, -- Group empty directories when opening trees
			use_libuv_file_watcher = true, -- Use libuv for faster file system event updates (recommended)
			window = {
				-- You can override window mappings specifically for the filesystem source
				mappings = {
					["H"] = "toggle_hidden", -- Toggle hidden files
					["I"] = "toggle_gitignore", -- Toggle gitignored files
					["<bs>"] = "navigate_up", -- Go up one directory
					["."] = "set_root", -- Set current node as root
				},
			},
		},

		-- Configuration for other sources (can be enabled by adding to `sources` table)
		buffers = {
			follow_current_file = { enabled = true },
			group_empty_dirs = true,
		},
		git_status = {
			window = {
				position = "float", -- Example: Show git status as a float
				mappings = {
					["A"] = "git_add_all",
					["gu"] = "git_unstage_file",
					["ga"] = "git_add_file",
					["gr"] = "git_revert_file",
					["gc"] = "git_commit",
					["gp"] = "git_push",
					["gg"] = "git_pull",
				},
			},
		},

		-- Define which sources are available and how to switch between them
		sources = { "filesystem", "buffers", "git_status" }, -- Available sources
		source_selector = {
			winbar = true, -- Show a clickable source selector in the winbar
			statusline = false, -- Don't show in statusline
			sources = { -- Configure display names and icons for the selector
				{ source = "filesystem", display_name = " 󰉓 Files " }, -- Requires Nerd Font
				{ source = "buffers", display_name = "  Buffers " }, -- Requires Nerd Font
				{ source = "git_status", display_name = " 󰊢 Git " }, -- Requires Nerd Font
			},
		},
	},
}
