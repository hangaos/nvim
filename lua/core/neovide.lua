-- ~/.config/nvim/lua/core/neovide.lua

-- Apply settings only when running in Neovide
if not vim.g.neovide then
	return -- Exit if not Neovide
end

-- print("Applying Neovide specific settings...") -- Commented out

-- ==================================
-- == Font Settings ==
-- ==================================
-- IMPORTANT: Replace "JetBrainsMono Nerd Font" with the EXACT name
-- of the Nerd Font you installed. Check Font Book app on macOS.
-- Format: "Font Name:h<size>" (e.g., :h14 for size 14)
vim.opt.guifont = "JetBrainsMono Nerd Font:h13" -- << SET YOUR FONT AND SIZE HERE

-- ==================================
-- == Visual Effects ==
-- ==================================
-- Transparency (0.0 = fully transparent, 1.0 = opaque)
-- vim.g.neovide_opacity = 0.99 -- Set your desired transparency level

-- Background Blur (Requires compositor support on macOS)
-- vim.g.neovide_blur = 0.1 -- Set > 0 to enable blur

-- Floating window transparency (optional)
-- vim.g.neovide_floating_blur = 0.0
-- vim.g.neovide_floating_transparency = 0.95

-- ==================================
-- == Cursor Effects ==
-- ==================================

-- Cursor VFX mode: "railgun", "torpedo", "pixiedust", "sonicboom", "ripple", "wireframe", "" (off)
vim.g.neovide_cursor_vfx_mode = ""

-- Optional VFX customization
-- vim.g.neovide_cursor_vfx_opacity = 200.0
-- vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
-- vim.g.neovide_cursor_vfx_particle_density = 7.0
-- vim.g.neovide_cursor_vfx_particle_speed = 10.0
vim.g.neovide_cursor_trail_size = 0
-- ==================================
-- == Window & Interaction ==
-- ==================================
-- Default fullscreen state
vim.g.neovide_fullscreen = false

-- Smooth scrolling animation length
vim.g.neovide_scroll_animation_length = 0.1

-- Hide mouse cursor when typing
vim.g.neovide_hide_mouse_when_typing = true

-- Enable/disable pinch-to-zoom gesture
vim.g.neovide_touch_zoom = false

-- Use standard macOS option key behavior for Alt mappings
vim.g.neovide_input_use_logo = true

-- Refresh rate (optional)
vim.g.neovide_refresh_rate = 60
-- vim.g.neovide_refresh_rate_idle = 5
