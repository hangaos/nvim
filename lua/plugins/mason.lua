return {
	{
		"williamboman/mason.nvim",
		cmd = "Mason", -- Tải khi gọi lệnh :Mason
		config = function()
			require("mason").setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		opts = {
			ensure_installed = {
				"ts_ls",
				"cssls",
				"html",
				"jsonls",
				"sqlls",
				"eslint",
				"lua_ls",
				"tailwindcss",
			},
			automatic_installation = true,
		},
	},
}
