-- ~/.config/nvim/config/options.lua
--
-- EDITOR OPTIONS
-- General behavior settings for the editor.
-- These have nothing to do with plugins — they are built-in Neovim settings.

vim.opt.number = true          -- Mostra o número da linha
vim.opt.relativenumber = true  -- Mostra a distância relativa das outras linhas

vim.opt.tabstop = 2       -- Tamanho visual de um tab
vim.opt.shiftwidth = 2    -- Tamanho da indentação com >> e
vim.opt.expandtab = true  -- Converte tabs em espaço

vim.opt.clipboard = "unnamedplus" -- Usa o clipboard do sistema

vim.opt.foldlevel = 99  -- Abre todos os folds ao abrir um arquivo
