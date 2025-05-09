return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	event = "BufEnter",
	opts = {
		options = {
			icons_enabled = true,
			theme = "auto",
			component_separators = "",
			section_separators = "",
			disabled_filetypes = {
				statusline = { "NvimTree", "neo-tree", "alpha", "dashboard", "lazy", "mason", "lir" },
				winbar = {},
			},
			always_divide_middle = true,
			globalstatus = false,
			refresh = {
				statusline = 200,
			},
		},
		sections = {
			lualine_a = {
				{
					"mode",
				},
			},
			lualine_b = {
				{
					"branch",
					icons_enabled = true,
					icon = "",
				},
				{
					"diff",
					symbols = { added = " ", modified = " ", removed = " " },
				},
			},
			lualine_c = {}, -- Không hiển thị tên file
			lualine_x = { -- Thứ tự mới: diagnostics trước
				{
					"diagnostics",
					sources = { "nvim_lsp" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					colored = true,
				},
			},
			lualine_y = { -- Chuyển location, encoding, filetype sang đây để theo đúng thứ tự mong muốn
				{
					function()
						local l = vim.fn.line(".")
						local c = vim.fn.col(".")
						return string.format("Ln %d Col %d", l, c)
					end,
				},
				{
					"encoding",
					fmt = string.upper,
				},
				{
					"filetype",
					colored = true,
					icon_only = false,
				},
			},
			lualine_z = {
				-- Để trống hoặc thêm component khác nếu muốn (ví dụ: datetime)
			},
		},
		inactive_sections = {
			lualine_a = { { "mode", gui = "italic" } },
			lualine_b = {},
			lualine_c = {},
			lualine_x = {
				{
					"diagnostics",
					sources = { "nvim_lsp" },
					symbols = { error = " ", warn = " ", info = " ", hint = " " },
					colored = true,
					gui = "italic",
				},
			},
			lualine_y = {
				{
					function()
						local l = vim.fn.line(".")
						local c = vim.fn.col(".")
						return string.format("Ln %d Col %d", l, c)
					end,
					gui = "italic",
				},
			},
			lualine_z = {},
		},
		tabline = {},
		winbar = {},
		inactive_winbar = {},
		extensions = { "neo-tree", "toggleterm", "lazy" },
	},
}
