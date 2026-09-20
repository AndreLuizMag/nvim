-- ~/.config/nvim-mini/init.lua
--
-- ENTRY POINT
-- This is the first file Neovim reads on startup.
-- It loads the core pieces of the configuration in order:
--   1. lazy.lua     → sets up the plugin manager and leader key
--   2. options.lua  → sets editor behavior (line numbers, indentation, etc.)
--   3. lsp.lua      → native LSP activation (empty for now, filled in Etapa 4)
--   4. neovide.lua  → GUI-only settings, a no-op in the terminal

require("config.lazy")
require("config.options")
require("config.lsp")
require("config.neovide")
