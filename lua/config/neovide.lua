-- lua/config/neovide.lua
--
-- NEOVIDE (GUI)
-- vim.g.neovide is set automatically by Neovide itself when it connects.
-- If this variable doesn't exist (i.e. you're in a terminal via `nvim .`),
-- the whole file is skipped — it doesn't affect your terminal session.

if not vim.g.neovide then
  return
end

-- Font: "Family:hSIZE" — same syntax as the native `guifont` option.
-- Use the FAMILY name ("Maple Mono"), not a face name ("Maple Mono Light"):
-- Neovide resolves fonts via DirectWrite/Skia and won't find face names.
-- Weight (Light etc.) can't be set through `guifont` in Neovide; only via
-- Neovide's own config.toml ([font] style = "Light"), outside this repo.
--
-- Comma-separated list = fallback: a glyph missing in the first font is taken
-- from the next. Maple Mono has no Nerd Font glyphs (mini.icons uses
-- U+E000+ and U+F0000+), so FiraCode Nerd Font Mono supplies them.
vim.o.guifont = 'Maple Mono:h12,FiraCode Nerd Font Mono:h12'

-- Vertical spacing between lines (pixels)
vim.opt.linespace = 4

-- Space between the OS window border and the buffer content
vim.g.neovide_padding_top = 12
vim.g.neovide_padding_bottom = 12
vim.g.neovide_padding_right = 12
vim.g.neovide_padding_left = 12

-- Cmd line hidden by default
vim.o.cmdheight = 0

-- Overall UI scale — works like a zoom, useful on high-DPI screens.
-- Neovide computes the final size as: guifont "h" × OS scale × this value.
-- On Linux (Wayland) the OS reports scale 1.0, so h12 above is already right.
-- On Windows the OS scale is rarely 1.0 ("Scale" in Settings > System >
-- Display), so the same h12 comes out bigger — compensate here.
if vim.fn.has('win32') == 1 then
  -- Formula: 1 / (scale% / 100). E.g. 125% -> 0.8 | 150% -> 0.67 | 175% -> 0.57
  vim.g.neovide_scale_factor = 0.8
else
  vim.g.neovide_scale_factor = 1.0
end

-- Animation duration (seconds). Lower for a snappier feel, 0 disables.
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_scroll_animation_length = 0.20

-- Ask for confirmation when closing with unsaved buffers
vim.g.neovide_confirm_quit = true
