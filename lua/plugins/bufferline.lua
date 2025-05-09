return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*",
	event = "VeryLazy",
	opts = {
		options = {
			mode = "tabs",
			themable = true,
			separator_style = "slant",
			show_buffer_icons = true,
			show_buffer_close_icons = true,
			show_close_icon = false,
			show_tab_indicators = true,
			numbers = "none",
			modified_icon = "●",
			buffer_close_icon = "",
			diagnostics = false, -- Tắt diagnostics trên bufferline
			-- diagnostics_indicator function đã được bỏ đi vì diagnostics = false
			offsets = {
				{
					filetype = "neo-tree",
					text = function()
						local root = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
						if root == "" or root == "~" then
							return "🌲 Neo-tree"
						end
						return "🌲 " .. root
					end,
					highlight = "Directory",
					text_align = "left",
					separator = true,
				},
			},
			always_show_bufferline = true,
		},
	},
}
