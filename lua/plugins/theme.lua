-- ~/.config/nvim/plugins/theme.lua
--
-- COLOR SCHEME
-- Loads the Adwaita theme (inspired by GNOME's default UI style).
--
-- lazy = false  → loads immediately on startup (not deferred)
-- priority = 1000 → loads before all other plugins to avoid a flash
--                   of the wrong colors at startup


return {
  {
    "Mofiqul/adwaita.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.adwaita_darker = false
      vim.g.adwaita_disable_cursorline = false
      vim.cmd("colorscheme adwaita")
    end,
  },
}
