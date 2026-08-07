-- ~/.config/nvim/lua/config/neovide.lua
--
-- NEOVIDE (GUI)
-- vim.g.neovide is set automatically by Neovide itself when it connects.
-- If this variable doesn't exist (i.e. you're in Ptyxis via `nvim .`),
-- the whole file is skipped — it doesn't affect your terminal session.

if not vim.g.neovide then
  return
end

-- Font: "Name:hSIZE" — same syntax as the native `guifont` option
vim.o.guifont = "Maple Mono Light:h11"

-- Vertical spacing between lines
vim.opt.linespace = 0

-- Space between the OS window border and the buffer content
vim.g.neovide_padding_top = 0
vim.g.neovide_padding_bottom = 0
vim.g.neovide_padding_right = 0
vim.g.neovide_padding_left = 0

-- Overall UI scale — works like a zoom, useful on high-DPI screens
vim.g.neovide_scale_factor = 1.0

-- Animation duration (seconds). Lower for a snappier feel,
-- or set to 0 to disable entirely.
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_scroll_animation_length = 0.20

-- Ask for confirmation when closing with unsaved buffers
vim.g.neovide_confirm_quit = true
