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
				"ts_ls", -- Cho TypeScript, JavaScript, TSX
				"cssls", -- Cho CSS
				"html", -- Cho HTML
				"jsonls", -- Cho JSON
				"sqlls", -- Cho SQL
				"eslint",
				"lua_ls",
				"lsp-tailwindcss",
			},
			automatic_installation = true,
		},
	},
}
