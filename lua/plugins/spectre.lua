-- lua/plugins/spectre.lua
return {
	"nvim-pack/nvim-spectre",
	dependencies = { "nvim-lua/plenary.nvim" }, -- Thường là dependency cần thiết
	-- cmd = "Spectre", -- Hoặc lazy load bằng event/keys
	-- event = "VeryLazy",
	opts = {
		-- Các tùy chọn mặc định của spectre khá tốt
		-- mapping = { -- Các keymap bên trong UI của Spectre
		--   ['toggle_line'] = {map = "dd", noremap = true, desc = "Toggle current line"},
		--   ['enter_file'] = {map = "<cr>", noremap = true, desc = "Open File"},
		--   -- ... và nhiều keymap khác
		-- },
		-- find_engine = {
		--   ['rg'] = {
		--     cmd = "rg",
		--     -- ... args ...
		--   },
		-- },
		-- is_insert_mode = false, -- Bắt đầu ở normal mode trong input
	},
	-- config = function(_, opts)
	--   require("spectre").setup(opts)
	-- end,
}
