-- ~/.config/nvim/init.lua
--
-- ENTRY POINT
-- This is the first file Neovim reads on startup.
-- It loads the three core pieces of the configuration in order:
--   1. lazy.lua  → sets up the plugin manager and leader key
--   2. options.lua → sets editor behavior (line numbers, indentation, etc.)
--   3. lsp.lua   → tells Neovim which language servers to activate

require("config.lazy")
require("config.options")
