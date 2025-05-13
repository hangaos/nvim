return {
	"gbprod/nord.nvim",
	version = false,
	lazy = false,
	priority = 1000,
	config = function()
		require("nord").setup({
			transparent = true,
			borders = false,

			styles = {

				comments = { italic = true },
				keywords = {},
				functions = {},
				variables = {},
			},
		})

		vim.cmd("colorscheme nord")
	end,
}
