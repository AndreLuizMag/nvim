-- ~/.config/nvim/init.lua
--
-- ENTRY POINT
-- This is the first file Neovim reads on startup.
-- It loads the core pieces of the configuration in order:
--   1. compiler.lua → points the Treesitter parser build at a working C compiler (Windows)
--   2. lazy.lua     → sets up the plugin manager and leader key
--   3. options.lua  → sets editor behavior (line numbers, indentation, etc.)
--   4. neovide.lua  → GUI-only settings, a no-op in the terminal

require("config.compiler")
require("config.lazy")
require("config.options")
require("config.neovide")
