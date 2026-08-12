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
vim.o.guifont = "Maple Mono Light:h12"

-- Vertical spacing between lines
vim.opt.linespace = 4

-- Space between the OS window border and the buffer content
vim.g.neovide_padding_top = 12
vim.g.neovide_padding_bottom = 12
vim.g.neovide_padding_right = 12
vim.g.neovide_padding_left = 12

--- Overall UI scale — works like a zoom, useful on high-DPI screens
vim.g.neovide_scale_factor = 1.0
-- Overall UI scale — works like a zoom, useful on high-DPI screens.
-- Neovide calcula o tamanho final como: guifont "h" × escala do SO × este valor.
-- No Bazzite (Wayland) o SO reporta escala 1.0, então h11 acima já sai correto.
-- No Windows a escala do SO quase nunca é 1.0 (é o "Scale" em Configurações >
-- Sistema > Vídeo), então o mesmo h11 sai maior lá — compensamos aqui.
if vim.fn.has("win32") == 1 then
  -- Fórmula: 1 / (escala% / 100). Ex.: 125% -> 0.8 | 150% -> 0.67 | 175% -> 0.57
  vim.g.neovide_scale_factor = 0.8
else
  vim.g.neovide_scale_factor = 1.0
end

-- Animation duration (seconds). Lower for a snappier feel,
-- or set to 0 to disable entirely.
vim.g.neovide_cursor_animation_length = 0.08
vim.g.neovide_scroll_animation_length = 0.20

-- Ask for confirmation when closing with unsaved buffers
vim.g.neovide_confirm_quit = true
