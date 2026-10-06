-- mini.files — https://nvim-mini.org/mini.nvim/doc/mini-files
-- Explorador de arquivos modal em janelas flutuantes (colunas lado a lado).
-- Navega e manipula o sistema de arquivos editando texto; `=` sincroniza.
require('mini.files').setup()

-- Abre no diretório do arquivo atual
vim.keymap.set('n', '<leader>e', function()
  MiniFiles.open(vim.api.nvim_buf_get_name(0))
end, { desc = 'Explorador de arquivos' })
