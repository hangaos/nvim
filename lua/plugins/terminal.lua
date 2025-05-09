return {
	"akinsho/toggleterm.nvim",
	version = "*", -- Or specify a git tag like 'v2.9.0' for stability
	-- No specific event needed if using `keys` or `cmd` for lazy-loading,
	-- but can add `event = "VeryLazy"` if preferred.
	-- `cmd = "ToggleTerm"` will also work if only using the command.
	opts = {
		-- Default size for new terminals.
		-- Can be a number (lines/columns) or a function.
		size = function(term)
			if term.direction == "horizontal" then
				return 15 -- Lines for horizontal split
			elseif term.direction == "vertical" then
				return math.floor(vim.o.columns * 0.4) -- 40% width for vertical split
			end
			-- Default float size
			return math.min(math.floor(vim.o.lines * 0.7), 40) -- 70% height, max 40 lines
		end,
		-- open_mapping = [[<A-t>]], -- We will define this in `keys` for better lazy-loading
		hide_numbers = true, -- Hide Neovim numbers in terminal buffers
		shade_filetypes = {}, -- Can specify filetypes to not shade (e.g. Telescope)
		shade_terminals = true, -- Dim inactive toggleterm windows
		shading_factor = "2", -- How much to dim (1 lightly, 10 heavily); '1' to '9' or a number
		start_in_insert = true, -- Start terminals in insert mode
		insert_mappings = true, -- Use Neovim's insert mode mappings in the terminal
		terminal_mappings = true, -- Use Neovim's terminal mode mappings in the terminal
		persist_size = true, -- Remember size across toggles
		persist_mode = true, -- Remember Neovim mode (normal/insert) across toggles
		direction = "float", -- Default direction for ToggleTerm command
		close_on_exit = true, -- Close the terminal window when the shell process exits
		shell = vim.o.shell, -- Use Neovim's default shell (e.g., zsh, bash)
		auto_scroll = true, -- Automatically scroll to the bottom on new output

		-- Floating terminal specific options
		float_opts = {
			border = "curved", -- Border style: 'single', 'double', 'rounded', 'curved', 'shadow'
			winblend = 10, -- Make floating window slightly transparent (0-100)
			-- width = <number>,      -- You can set a fixed width
			-- height = <number>,     -- You can set a fixed height
			-- row = <number>,        -- Fixed row position
			-- col = <number>,        -- Fixed col position
			highlights = { -- Optional: custom highlights for border and background
				border = "FloatBorder",
				background = "Normal",
			},
		},

		-- Winbar options (if you want a little bar above the terminal)
		-- winbar = {
		--   enabled = false,
		--   name_formatter = function(term) return term.name end,
		-- },
	},
	-- Define keymaps using lazy.nvim's `keys` table
	-- These will also act as triggers for lazy-loading the plugin
	keys = {
		-- Main toggle for a floating terminal
		{ "<leader>tr", "<cmd>ToggleTerm<cr>", mode = { "n", "t" }, desc = "ToggleTerm (Float)" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", mode = "n", desc = "ToggleTerm Float" },
		-- Toggle vertical terminal
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<cr>", mode = "n", desc = "ToggleTerm Vertical" },
		-- Toggle horizontal terminal
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<cr>", mode = "n", desc = "ToggleTerm Horizontal" },
		-- Example: Toggle a terminal for lazygit (if lazygit is installed)
		{ "<leader>lg", "<cmd>ToggleTerm cmd='lazygit' direction=float<cr>", mode = "n", desc = "ToggleTerm lazygit" },
		-- Example: Toggle a terminal for Python REPL
		{
			"<leader>tp",
			"<cmd>ToggleTerm cmd='python' direction=float<cr>",
			mode = "n",
			desc = "ToggleTerm Python REPL",
		},

		-- Keymaps for inside terminal mode (prefix with <C-\><C-n> to escape to Normal mode first)
		-- Example: Close terminal from terminal mode
		-- { "<Esc>", "<C-\\><C-n>:ToggleTerm<CR>", mode = "t", desc = "ToggleTerm from Terminal" },
		-- Example: Navigate Neovim windows from terminal mode
		-- { "<C-h>", "<C-\\><C-n><C-w>h", mode = "t", desc = "Terminal: Win Left" },
		-- { "<C-j>", "<C-\\><C-n><C-w>j", mode = "t", desc = "Terminal: Win Down" },
		-- { "<C-k>", "<C-\\><C-n><C-w>k", mode = "t", desc = "Terminal: Win Up" },
		-- { "<C-l>", "<C-\\><C-n><C-w>l", mode = "t", desc = "Terminal: Win Right" },
	},
}
