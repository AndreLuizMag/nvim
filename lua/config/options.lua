-- ~/.config/nvim-mini/lua/config/options.lua
--
-- EDITOR OPTIONS
-- Comportamento nativo do editor, sem depender de nenhum plugin.

vim.opt.number = true          -- Mostra o número da linha
vim.opt.relativenumber = true  -- Mostra a distância relativa das outras linhas

-- Sempre reserva a coluna de sinais. Sem isso ela é criada sob demanda, e o
-- texto inteiro desloca lateralmente assim que o mini.diff marca o primeiro hunk.
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2       -- Largura visual de uma tab
vim.opt.shiftwidth = 2    -- Largura de indentação com >> e <<
vim.opt.expandtab = true  -- Converte tabs em espaços

vim.opt.clipboard = "unnamedplus" -- Usa o clipboard do sistema

-- QUEBRA DE LINHA
vim.opt.wrap = false -- Não quebra linhas longas visualmente por padrão

local wrap_group = vim.api.nvim_create_augroup("wrap_filetypes", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = wrap_group,
  pattern = { "markdown", "text" }, -- Só quebra em .md e .txt
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true -- Quebra nos limites de palavra, não no meio
  end,
})

vim.opt.foldlevel = 99 -- Todos os folds começam abertos ao abrir um arquivo
