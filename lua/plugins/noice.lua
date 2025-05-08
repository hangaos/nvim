return {
	"folke/noice.nvim",
	event = "VimEnter",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify", -- Ensure notify.lua is configured with timeout and vim.notify override
	},
	opts = {
		-- LSP UI enhancements
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- For nvim-cmp documentation
			},
			progress = {
				enabled = true, -- Show LSP progress messages via Noice UI
				-- Options for LSP progress spinner and text
				-- LspProgressFunction = "", -- Example spinner
				-- LspProgressFormat = "LSP: {server} {message}"
			},
			hover = {
				enabled = true, -- Noice handles hover
				border = "rounded", -- Border for hover windows
			},
			signature = {
				enabled = true, -- Noice handles signature help
				border = "rounded", -- Border for signature help windows
			},
		},

		-- UI Presets
		presets = {
			bottom_search = false, -- Search input will use a Noice view (popup/palette)
			command_palette = true, -- Cmdline becomes a command palette
			long_message_to_split = true,
			inc_rename = false, -- Use Neovim's default for :IncRename
			lsp_doc_border = true, -- Adds border to standalone LSP documentation windows
		},

		-- Command line configuration
		cmdline = {
			enabled = true, -- Noice manages the cmdline
			format = { -- Icons and formatting for different cmdline types
				cmdline = { pattern = "^:", icon = " ", lang = "vim" },
				search_down = { pattern = "^/", icon = " ", lang = "regex" },
				search_up = { pattern = "^%?", icon = " ", lang = "regex" },
				filter = { pattern = "^:%s*!", icon = "$ ", lang = "bash" },
				lua = { pattern = "^:%s*lua%s+", icon = " ", lang = "lua" },
				help = { pattern = "^:%s*he?l?p?%s+", icon = "󰋗 " },
			},
		},

		-- Message handling
		messages = {
			enabled = true, -- Noice takes over vim.notify
			view = "notify", -- Default view for messages (uses nvim-notify)
			view_error = "notify", -- Errors also use nvim-notify
			view_warn = "notify", -- Warnings also use nvim-notify
			view_history = "messages", -- For :messages command (opens a split)
			view_search = "popup", -- "N results" for search in a popup (can be "null" to hide)
		},

		-- Routes: Fine-tune message handling (optional for more control)
		routes = {
			{
				filter = { event = "msg_show", kind = "" }, -- Catches general messages like print() if routed via vim.notify
				view = "notify",
			},
			{
				filter = { event = "msg_show", kind = "search_count" },
				opts = { skip = true }, -- Hide "N matches on M lines" message for a cleaner search UI
			},
			-- Example: Route specific LSP progress messages to a less intrusive view
			-- {
			--   filter = { event = "lsp", kind = "progress" },
			--   view = "mini", -- A minimal, less intrusive view for progress
			-- },
		},

		-- Views: Customize the appearance of Noice UIs
		views = {
			cmdline_popup = {
				position = { row = "95%", col = "98%", anchor = "SE" }, -- Position higher up
				size = { width = "30%", min_width = 60, height = "auto" },
				border = { style = "rounded", padding = { 0, 1 } },
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					winblend = 10, -- Subtle transparency (0-100, 0 is opaque)
				},
			},
			popup = { -- For general popups like vim.ui.select, completion docs if routed here
				border = { style = "rounded" },
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					winblend = 10,
				},
			},
			search_popup = { -- View for search input if bottom_search = false
				position = { row = "20%", col = "50%" },
				size = { width = "60%", min_width = 60, height = "auto" },
				border = { style = "rounded", padding = { 0, 1 } },
				win_options = {
					winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
					winblend = 10,
				},
			},
			split = { -- For long messages routed to a split
				enter = true, -- Focus the split on open
				position = "bottom",
				size = "40%",
				border = { style = "rounded" },
			},
		},
	},
}
