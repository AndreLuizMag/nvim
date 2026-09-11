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
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({})

      -- "lua" entra aqui também: a query de highlighting que vem com essa
      -- branch do nvim-treesitter sobrescreve a do Neovim core na runtimepath,
      -- então o parser de lua precisa vir do mesmo pacote pra não dar
      -- incompatibilidade (foi isso que causou o erro "Invalid field name").
      require("nvim-treesitter").install({
        "lua",
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "scss",
        "json",
      })

      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "javascript",
          "typescript",
          "typescriptreact",
          "javascriptreact",
          "html",
          "css",
          "scss",
          "json",
        },
        callback = function()
          -- Se o parser daquela linguagem ainda não foi compilado, start()
          -- levanta erro e o arquivo abre com uma mensagem vermelha. Aqui a
          -- ausência do parser vira só um highlight sem treesitter.
          if not pcall(vim.treesitter.start) then
            return
          end
          vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.wo[0][0].foldmethod = "expr"
        end,
      })
    end,
  },
}
