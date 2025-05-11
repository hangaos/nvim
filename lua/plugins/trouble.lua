return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	cmd = { "TroubleToggle", "Trouble" },
	opts = {
		auto_open = false,
		auto_close = false,
		auto_preview = true,
		auto_refresh = true,
		auto_jump = { "lsp_definitions", "lsp_references", "lsp_implementations" },
		signs = {
			error = "",
			warning = "",
			hint = "",
			information = "",
		},
		use_diagnostic_signs = false, -- Hoặc true nếu muốn dùng icons từ vim.diagnostic.config
		padding = true,
		indent_lines = true,
		win_config = {
			position = "bottom",
			size = 10, -- Số dòng chiều cao
			-- min_height = 5, -- Chiều cao tối thiểu
			-- relative = "editor",
			-- border = "rounded", -- "none", "single", "double", "rounded", "solid", "shadow"
		},
		modes = {
			diagnostics = {
				mode = "workspace", -- "workspace", "document", "cursor"
				auto_preview = true,
				groups = { "error", "warning", "info", "hint" }, -- Thứ tự và các group hiển thị
			},
			lsp_references = {
				mode = "workspace",
				auto_preview = vim.fn.executable("rg") == 1, -- Chỉ auto preview nếu có ripgrep
				warn_no_results = true,
			},
			lsp_definitions = { mode = "workspace", auto_preview = true },
			lsp_implementations = { mode = "workspace", auto_preview = true },
			lsp_type_definitions = { mode = "workspace", auto_preview = true },
			quickfix = { auto_preview = true },
			loclist = { auto_preview = true },
			-- treesitter = { auto_open = true }, -- Có thể thêm nếu dùng cho Treesitter symbols
		},
		action_keys = {
			close = { "q", "<esc>" },
			cancel = "<c-c>",
			refresh = "r",
			jump = { "<cr>", "<tab>", "o" },
			jump_close = { "O" },
			toggle_mode = "m",
			toggle_preview = "P",
			hover = "K",
			preview = "p",
			open_split = { "<c-s>", "<c-x>" }, -- <c-x> giống quickfix
			open_vsplit = "<c-v>",
			open_tab = "<c-t>",
			jump_buffer_vsplit = "gV",
			jump_buffer_split = "gS",
			previous = "k",
			next = "j",
			help = "?",
		},
		severity_sort = true, -- Sắp xếp theo mức độ nghiêm trọng
		multiline_diagnostics = true, -- Hiển thị diagnostics nhiều dòng nếu có
		focus_results = true, -- Tự động focus vào cửa sổ trouble khi mở
	},
}
