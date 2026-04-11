-- ~/.config/nvim/plugins/treesitter.lua
--
-- SYNTAX HIGHLIGHTING AND CODE FOLDING (Treesitter)
-- Treesitter parses source code into a syntax tree, enabling:
--   - More accurate syntax highlighting than regex-based approaches
--   - Smarter indentation
--   - Code folding based on actual code structure (functions, blocks, etc.)
--
-- The autocommand at the bottom activates Treesitter-based folding for
-- every file type. Combined with foldlevel=99 in options.lua, all folds
-- start open — you can close them manually with the 'z' commands.


return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },  -- carrega ao abrir qualquer arquivo
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript", "typescript", "tsx",
          "html", "css", "json", "lua",
        },
        compilers = { "zig", "gcc", "cl" },
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- Enable fold-by-structure for all file types
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "*" },
        callback = function()
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
        end,
      })
    end,
  },
}
