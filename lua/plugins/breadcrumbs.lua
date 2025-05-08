return {
	{
		"SmiteshP/nvim-navic",
		dependencies = { "neovim/nvim-lspconfig" }, -- Relies on an active LSP server
		opts = {
			lsp = {
				auto_attach = true, -- Automatically attach to LSP servers
        preferred_servers = { "ts_ls", "eslint" },
                filter = function(client)
          -- client.name là tên của LSP server (ví dụ: "ts_ls", "graphql", "eslint")
          -- Nếu tên là "graphql", mình sẽ trả về false để Navic bỏ qua nó.
          if client.name == "graphql" then
            -- In ra thông báo nhỏ để biết filter có chạy (bạn có thể xóa dòng print này sau)
            -- print("nvim-navic: Ignoring client: " .. client.name)
            return false
          end
          -- Cho phép tất cả các client khác
          return true
        end,
			},
			highlight = true, -- Enable highlighting of navic text
			separator = " › ", -- Character used to separate context elements
			depth_limit = 5, -- Maximum depth of context to display
			depth_limit_indicator = "..", -- Indicator shown when depth limit is reached
			click = true, -- Allow clicking on navic components to jump to definition
		},
	},
	{
		"utilyre/barbecue.nvim",
		dependencies = {
			"SmiteshP/nvim-navic", -- Requires nvim-navic for data
			"nvim-tree/nvim-web-devicons", -- For icons in the breadcrumbs
		},
		event = "VeryLazy", -- Load when really needed
		opts = {
			create_autocmd = true, -- Automatically update on events like BufEnter, CursorHold
			theme = "auto", -- Attempt to match the current colorscheme (Kansō)
			-- If 'auto' doesn't look good, try specific themes like 'tokyonight',
			-- 'catppuccin', 'onedark', or barbecue's own themes.
			icons = true, -- Enable icons from nvim-web-devicons
			contextual_breadcrumbs = true, -- Prefer contextual path (e.g., class > method)

			-- Filetypes to exclude from showing breadcrumbs
			exclude_filetypes = {
				"gitcommit",
				"markdown", -- Can be noisy in markdown, enable if desired
				"NvimTree",
				"neo-tree", -- Exclude for neo-tree as well
				"alpha",
				"starter",
				"dashboard",
				"lazy",
				"mason",
				"help",
				"Trouble",
				"Outline", -- If using lspsaga or similar for outline
			},
		},
	},
}
