--
-- mini.pick — https://nvim-mini.org/mini.nvim/doc/mini-pick
-- Picker (busca interativa) de arquivos, texto no projeto, buffers e help.
-- Usa ripgrep (rg) quando disponível, mini.icons para ícones e substitui
-- vim.ui.select (ex.: code actions do LSP).
--
-- Mapeamentos padrão dentro do picker:
-- <C-n>/<C-p> move, <CR> escolhe, <C-s>/<C-v>/<C-t> abre em split/vsplit/aba,
-- <Tab> preview, <S-Tab> info, <C-x> marca, <C-a> marca todos,
-- <M-CR> escolhe marcados, <C-Space> refina, <Esc> fecha.
--

require('mini.pick').setup()

vim.keymap.set('n', '<leader>ff', '<Cmd>Pick files<CR>', { desc = 'Pick files' })
vim.keymap.set('n', '<leader>fg', '<Cmd>Pick grep_live<CR>', { desc = 'Pick grep live' })
vim.keymap.set('n', '<leader>fb', '<Cmd>Pick buffers<CR>', { desc = 'Pick buffers' })
vim.keymap.set('n', '<leader>fh', '<Cmd>Pick help<CR>', { desc = 'Pick help' })
vim.keymap.set('n', '<leader>fr', '<Cmd>Pick resume<CR>', { desc = 'Pick resume' })
