-- ~/.config/nvim/config/options.lua
--
-- EDITOR OPTIONS
-- General behavior settings for the editor.
-- These have nothing to do with plugins — they are built-in Neovim settings.

vim.opt.number = true          -- Show the line number
vim.opt.relativenumber = true  -- Show the relative distance to other lines

vim.opt.tabstop = 2       -- Visual width of a tab
vim.opt.shiftwidth = 2    -- Indentation width with >> and 
vim.opt.expandtab = true  -- Convert tabs to spaces

vim.opt.clipboard = "unnamedplus" -- Use the system clipboard

vim.opt.foldlevel = 99  -- Open all folds when opening a file
