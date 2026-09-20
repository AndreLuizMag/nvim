-- ~/.config/nvim-mini/lua/config/options.lua
--
-- EDITOR OPTIONS
-- Comportamento nativo do editor, sem depender de nenhum plugin.

vim.opt.number = true          -- Mostra o número da linha
vim.opt.relativenumber = true  -- Mostra a distância relativa das outras linhas

vim.opt.tabstop = 2       -- Largura visual de uma tab
vim.opt.shiftwidth = 2    -- Largura de indentação com >> e <<
vim.opt.expandtab = true  -- Converte tabs em espaços

vim.opt.clipboard = "unnamedplus" -- Usa o clipboard do sistema

vim.opt.foldlevel = 99 -- Todos os folds começam abertos ao abrir um arquivo
