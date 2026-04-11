-- ~/.config/nvim/config/lazy.lua
--
-- PLUGIN MANAGER (lazy.nvim)
-- This file installs lazy.nvim (if it's not already installed) and
-- configures it to load all plugins from the plugins/ folder.
--
-- NOTE: The leader key (<Space>) must be defined HERE, before lazy.nvim
-- loads any plugin. If it were defined later, some plugin keymaps might
-- not register correctly.

-- Install lazy.nvim automatically if it's missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Leader key: <Space> is used as the prefix for custom keymaps (e.g. <Space>ff to find files)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Start lazy.nvim and point it at the plugins/ folder
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = {
    enabled = true,   -- Check for plugin updates automatically
    notify = false,   -- Don't show a notification on startup
  },
})
