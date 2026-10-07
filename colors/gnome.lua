-- gnome — tema gerado pelo mini.hues (https://nvim-mini.org/mini.nvim/doc/mini-hues)
-- Cores base do GNOME (Adwaita dark): fundo #222226, texto #ffffff.
-- Só dark. Demais opções (n_hues, saturation, accent) nos defaults do módulo.
require('mini.hues').setup({
  background = '#222226',
  foreground = '#ffffff',
})
vim.g.colors_name = 'gnome'
