-- mini.diff — https://nvim-mini.org/mini.nvim/doc/mini-diff
-- Mostra na coluna de sinais o que mudou no buffer em relação ao git index
-- (adicionado, alterado, removido), atualizando enquanto digita. Requer git 2.38+.
-- Mapeamentos padrão: ]h / [h próximo / anterior hunk, ]H / [H último / primeiro,
-- gh aplica (stage) hunk, gH reseta hunk, gh também é text object (ex.: vgh).
local diff = require('mini.diff')

diff.setup({
  view = {
    -- Padrão vira 'number' quando `number` está ligado; aqui queremos a coluna de sinais.
    style = 'sign',
    -- Padrão é '▒' (bloco cheio). '▏' desenha só uma barra fina à esquerda.
    signs = { add = '▏', change = '▏', delete = '▏' },
  },
})

-- Overlay com o diff completo inline (sem mapping padrão na doc)
vim.keymap.set('n', '<leader>gd', diff.toggle_overlay, { desc = 'Alternar overlay do git diff' })
