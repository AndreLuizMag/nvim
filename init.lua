-- Instala plugins via gerenciador nativo do Neovim 0.12+
-- mini.nvim (branch stable): https://nvim-mini.org/mini.nvim/#installation
vim.pack.add({
  { src = 'https://github.com/nvim-mini/mini.nvim', version = 'stable' },
  { src = 'https://github.com/neovim/nvim-lspconfig' },
  { src = 'https://github.com/mason-org/mason.nvim' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim' },
})

require('config.options')
-- require('config.ruler')
require('config.neovide')
require('config.lsp')
require('plugins.mini-hues')
require('plugins.mini-icons')
require('plugins.mini-files')
require('plugins.mini-diff')
require('plugins.nvim-lspconfig')
require('plugins.mason')
require('plugins.mason-lspconfig')
