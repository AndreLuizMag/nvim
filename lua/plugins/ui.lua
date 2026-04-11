-- ~/.config/nvim/plugins/ui.lua
--
-- USER INTERFACE ENHANCEMENTS
-- Visual additions that improve readability without changing editor behavior.
--
-- indent-blankline → draws a thin vertical line (│) at each indentation level,
--                    making nested code blocks easier to scan visually.
--                    Scope highlighting marks the block the cursor is currently in.


return {
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup({
        indent = {
          char = "│",  -- Caractere usado para a guia
        },
        scope = {
          enabled = true,  -- Highlight the indentation level of the current block
        },
      })
    end,
  },
}
