return {
	"rcarriga/nvim-notify",
	event = "VeryLazy",
	opts = {
		timeout = 2000,
		stages = "fade_in_slide_out",
		render = "compact",
		icons = {
			ERROR = "",
			WARN = "",
			INFO = "",
			DEBUG = "",
			TRACE = "✎",
		},
		level = vim.log.levels.INFO,
		top_down = true,
	},
	config = function(_, opts)
		require("notify").setup(opts)
		vim.notify = require("notify")
	end,
}
