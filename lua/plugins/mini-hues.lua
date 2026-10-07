-- mini.hues — https://nvim-mini.org/mini.nvim/doc/mini-hues
-- Gerador de tema a partir de cor de fundo + frente (espaço Oklch).
-- Tema próprio: `gnome`, definido em colors/gnome.lua (setup + colors_name).
-- mini.nvim também traz variantes prontas: miniwinter, minispring, minisummer,
-- miniautumn, randomhue. Todas respeitam vim.o.background (dark/light).
-- Trocar em tempo real: `:colorscheme minispring`
vim.o.background = 'dark'
vim.cmd.colorscheme('gnome')
