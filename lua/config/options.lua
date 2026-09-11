-- ~/.config/nvim/config/options.lua
--
-- EDITOR OPTIONS
-- General behavior settings for the editor.
-- These have nothing to do with plugins — they are built-in Neovim settings.

vim.opt.number = true          -- Show the line number
vim.opt.relativenumber = true  -- Show the relative distance to other lines

-- Always reserve the sign column. Without this it is created on demand, so the
-- whole text shifts sideways the moment mini.diff marks the first hunk.
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2       -- Visual width of a tab
vim.opt.shiftwidth = 2    -- Indentation width with >> and 
vim.opt.expandtab = true  -- Convert tabs to spaces

vim.opt.clipboard = "unnamedplus" -- Use the system clipboard

-- FOLDING
vim.opt.foldmethod = "expr" -- Use Treesitter to determine fold boundaries
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Expression that provides the fold levels
vim.opt.foldlevel = 99 -- Maximum fold depth before folds start closed
vim.opt.foldlevelstart = 99 -- Open all folds when opening a file
vim.opt.foldenable = true -- Enable folding
