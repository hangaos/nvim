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
			diagnostics = false,

			offsets = {
				{
					filetype = "neo-tree",
					text = function()
						local cwd = vim.fn.getcwd()
						local git_root_parts =
							vim.fn.systemlist("git -C " .. vim.fn.escape(cwd, " ") .. " rev-parse --show-toplevel")
						local git_root = git_root_parts and git_root_parts[1] or nil

						if
							git_root
							and #git_root > 0
							and vim.loop.fs_stat(git_root)
							and vim.loop.fs_stat(git_root).type == "directory"
						then
							return "🌲 Project: " .. vim.fn.fnamemodify(git_root, ":t")
						else
							local home_dir = vim.fn.expand("~")
							if cwd == home_dir then
								return "🌳 Home Explorer"
							elseif cwd == "/" then
								return "🧭 Root Directory"
							else
								local current_folder_name = vim.fn.fnamemodify(cwd, ":t")
								if
									current_folder_name ~= ""
									and current_folder_name ~= "."
									and current_folder_name ~= "~"
								then
									return "󰉋 Folder: " .. current_folder_name
								else
									return "󰉓 File Explorer"
								end
							end
						end
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
