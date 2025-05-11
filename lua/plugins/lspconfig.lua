return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"williamboman/mason.nvim",
		"hrsh7th/cmp-nvim-lsp",
		{ "RRethy/vim-illuminate", event = { "BufReadPost", "BufNewFile" } },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local keymap = vim.keymap.set

		local diagnostic_icons = {
			Error = " ",
			Warn = " ",
			Info = " ",
			Hint = " ",
		}

		vim.diagnostic.config({
			virtual_text = true,
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = diagnostic_icons.Error,
					[vim.diagnostic.severity.WARN] = diagnostic_icons.Warn,
					[vim.diagnostic.severity.INFO] = diagnostic_icons.Info,
					[vim.diagnostic.severity.HINT] = diagnostic_icons.Hint,
				},
			},
			underline = true,
			update_in_insert = false,
			severity_sort = true,
		})

		local on_attach = function(client, bufnr)
			vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

			local map_opts = { noremap = true, silent = true, buffer = bufnr }
			local lsp_cmds = vim.lsp.buf

			keymap("n", "K", lsp_cmds.hover, map_opts)
			keymap("n", "gd", lsp_cmds.definition, map_opts)
			keymap("n", "gD", lsp_cmds.declaration, map_opts)
			keymap("n", "gi", lsp_cmds.implementation, map_opts)
			keymap("n", "gr", lsp_cmds.references, map_opts)
			keymap("n", "<leader>rn", lsp_cmds.rename, map_opts)
			keymap("n", "<leader>ca", lsp_cmds.code_action, map_opts)
			keymap("v", "<leader>ca", lsp_cmds.code_action, map_opts)

			keymap("n", "[d", vim.diagnostic.goto_prev, map_opts)
			keymap("n", "]d", vim.diagnostic.goto_next, map_opts)
			keymap("n", "<leader>dl", vim.diagnostic.open_float, map_opts)
			keymap("n", "<leader>qf", vim.diagnostic.setloclist, map_opts)

			if client.server_capabilities.documentHighlightProvider then
				vim.api.nvim_create_autocmd("CursorHold", {
					buffer = bufnr,
					callback = vim.lsp.buf.document_highlight,
				})
				vim.api.nvim_create_autocmd("CursorMoved", {
					buffer = bufnr,
					callback = vim.lsp.buf.clear_references,
				})
			end
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

		local servers = {
			ts_ls = {},
			cssls = {},
			html = {},
			jsonls = {},
			sqlls = {},
			eslint = {},
			graphql = {
				filetypes = { "graphql", "gpl" },
			},
			lua_ls = {
				settings = {
					Lua = {
						runtime = {
							version = "LuaJIT",
						},
						diagnostics = {
							globals = { "vim" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false, --  To avoid issues with some plugins
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
		}

		for server_name, server_opts in pairs(servers) do
			local final_opts = vim.tbl_deep_extend("force", {
				on_attach = on_attach,
				capabilities = capabilities,
			}, server_opts or {})

			lspconfig[server_name].setup(final_opts)
		end
	end,
}
