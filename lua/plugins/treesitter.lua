return {
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" }, -- Tải khi mở file hoặc tạo file mới
		build = ":TSUpdate", -- Tự động cập nhật parsers
		dependencies = {
			-- Plugin này cung cấp thêm các text objects dựa trên treesitter
			-- Ví dụ: chọn một hàm, một class, một khối lệnh if, v.v.
			"nvim-treesitter/nvim-treesitter-textobjects",
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				-- Danh sách các parser sẽ được cài đặt.
				-- Bạn có thể thêm/bớt tùy theo nhuG cầu.
				ensure_installed = {
					"c",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"javascript",
					"typescript",
					"tsx",
					"html",
					"css",
					"json",
					"yaml",
					"sql",
					"markdown",
					"bash",
					-- Thêm các ngôn ngữ khác bạn cần ở đây, ví dụ: 'python', 'rust', 'go', 'java'
				},

				-- Tự động cài đặt các parser còn thiếu khi mở file (nếu chưa có trong ensure_installed)
				auto_install = true,

				-- Không block Neovim khi đang cài đặt parser (chạy ngầm)
				sync_install = false,

				-- Kích hoạt module highlighting
				highlight = {
					enable = true,
					-- Một số ngôn ngữ có filetype lớn có thể làm chậm, có thể disable nếu cần
					-- disable = { "latex" },
				},

				-- Kích hoạt module hỗ trợ thụt đầu dòng (indentation)
				indent = {
					enable = true,
					-- disable = { "python" }, -- Ví dụ: disable cho python nếu bạn dùng indent plugin khác
				},

				-- Kích hoạt module chọn code tăng tiến (incremental selection)
				-- Keymap cho tính năng này nên được đặt trong file keymaps.lua của bạn để dễ quản lý
				-- Ví dụ: vim.keymap.set("n", "<leader>si", ":TSNodeUnderCursor<CR>", { desc = "Treesitter Inspect Node" })
				--         vim.keymap.set("x", "J", ":TSNodeIncremental<CR>", { desc = "Treesitter Incremental Selection" })
				--         vim.keymap.set("x", "K", ":TSNodeSwapWith Sibling<CR>", { desc = "Treesitter Swap Node" })
				incremental_selection = {
					enable = true,
					-- Các keymap mặc định khá ổn, hoặc bạn có thể tự định nghĩa keymaps riêng
					-- keymaps = {
					--   init_selection = "<c-space>", -- Bắt đầu incremental selection
					--   node_incremental = "<c-space>", -- Mở rộng theo node hiện tại
					--   scope_incremental = "<c-s>", -- Mở rộng theo scope (ví dụ: cả function)
					--   node_decremental = "<c-backspace>", -- Thu hẹp
					-- },
				},

				-- Cấu hình cho nvim-treesitter-textobjects
				-- Module này đã được chuyển một phần vào core của nvim-treesitter
				-- nhưng plugin nvim-treesitter-textobjects vẫn cung cấp nhiều lựa chọn và tùy biến hơn.
				textobjects = {
					select = {
						enable = true,
						lookahead = true, -- Nhìn xa hơn để chọn text object chính xác hơn
						keymaps = {
							-- Ví dụ: 'af' = around function, 'if' = inner function
							["af"] = "@function.outer",
							["if"] = "@function.inner",
							["ac"] = "@class.outer",
							["ic"] = "@class.inner",
							-- Thêm các text object khác bạn muốn
							-- ví dụ: parameters, comments, loops, conditionals
							["aP"] = "@parameter.outer",
							["iP"] = "@parameter.inner",
							["aC"] = "@comment.outer", -- Chọn cả comment (kể cả dòng comment)
							["iC"] = "@comment.inner", -- Chọn nội dung bên trong comment
							["aa"] = "@assignment.outer", -- Chọn cả vế gán (lhs + rhs)
							["ia"] = "@assignment.inner", -- Chọn vế phải của phép gán (rhs)
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
							["at"] = "@conditional.outer",
							["it"] = "@conditional.inner",
						},
					},
					move = {
						enable = true,
						set_jumps = true, -- Lưu vị trí vào jumplist khi di chuyển
						goto_next_start = {
							["]m"] = "@function.outer",
							["]c"] = "@class.outer",
							-- Thêm các keymap di chuyển khác
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]C"] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[c"] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[C"] = "@class.outer",
						},
					},
					swap = {
						enable = true,
						swap_next = {
							["<leader>a"] = "@parameter.inner", -- Hoán đổi parameter với cái tiếp theo
						},
						swap_previous = {
							["<leader>A"] = "@parameter.inner", -- Hoán đổi parameter với cái trước đó
						},
					},
				},
			})
		end,
	},
}
