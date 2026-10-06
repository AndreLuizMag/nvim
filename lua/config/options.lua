-- lua/config/options.lua
--
-- EDITOR OPTIONS
-- General behavior settings for the editor.
-- These have nothing to do with plugins — they are built-in Neovim settings.

-- Opções gerais do Neovim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.number = true          -- Show the line number
vim.opt.relativenumber = true  -- Show the relative distance to other lines

-- Always reserve the sign column. Without this it is created on demand, so the
-- whole text shifts sideways when the first LSP diagnostic or mini.diff sign appears.
vim.opt.signcolumn = "yes"

vim.opt.tabstop = 2       -- Visual width of a tab
vim.opt.shiftwidth = 2    -- Indentation width with >> and <<
vim.opt.expandtab = true  -- Convert tabs to spaces

vim.opt.clipboard = "unnamedplus" -- Use the system clipboard

-- LINE WRAPPING
vim.opt.wrap = false -- Don't visually wrap long lines by default

local wrap_group = vim.api.nvim_create_augroup("wrap_filetypes", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = wrap_group,
  pattern = { "markdown", "text" }, -- Only wrap in .md and .txt files
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true -- Break at word boundaries, not mid-word
  end,
})
