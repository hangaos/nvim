return {
	"akinsho/bufferline.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	version = "*", -- Use latest stable release
	event = "VeryLazy", -- Load when needed
	opts = {
		options = {
			mode = "tabs",
			themable = true, -- ESSENTIAL: Allows the main colorscheme (Kansō) to style the bufferline
			separator_style = "slant", -- A commonly used and often pleasant separator style.
			-- Other options: "thin" (like |), "arrow", "padded_slant", "default" (powerline), or { '', '' } for no separator.
			show_buffer_icons = true,
			show_buffer_close_icons = true, -- Shows close icon on each buffer tab
			show_close_icon = false, -- Do not show an additional global close icon (show_buffer_close_icons handles per-buffer)
			show_tab_indicators = true, -- Shows modified status and diagnostics
			numbers = "none", -- "ordinal" (1,2,3), "buffer_id", "both", or a function
			modified_icon = "●",
			buffer_close_icon = "", -- Requires Nerd Font

			-- Display diagnostics from nvim_lsp for the *current* buffer only to reduce clutter
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level, diagnostics_dict, context)
				if context.buffer:current() then -- Only show for the current buffer
					local s = " "
					for e, n in pairs(diagnostics_dict) do
						local sym = ""
						if e == "error" then
							sym = " " -- Nerd Font Error icon
						elseif e == "warning" then
							sym = " " -- Nerd Font Warning icon
						elseif e == "info" then
							sym = " " -- Nerd Font Info icon
						elseif e == "hint" then
							sym = " " -- Nerd Font Hint icon (or 💡)
						end
						s = s .. n .. sym
					end
					return s
				end
				return "" -- Return empty for non-current buffers
			end,

			-- Offsets for other UI elements like NvimTree
			offsets = {
				{
					filetype = "NvimTree",
					text = "File Explorer", -- Or just "" for no text
					text_align = "left",
					separator = true, -- Show a separator next to the NvimTree offset
				},
				-- Example for a right-side offset (if you add other plugins there)
				-- {
				--   filetype = "Outline", -- Example, for an outline plugin
				--   text = "Symbols",
				--   text_align = "right",
				--   separator = true
				-- }
			},
			always_show_bufferline = true, -- Show bufferline even with only one buffer
			-- sort_by = 'tabs', -- Default, keeps buffer order as tabs are opened/moved
		},
	},
}
