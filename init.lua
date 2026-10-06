-- Instala mini.nvim (branch stable) via gerenciador nativo do Neovim 0.12+
-- Ref: https://nvim-mini.org/mini.nvim/#installation
vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
})

require('config.options')
require('plugins.mini-icons')
require('plugins.mini-files')
