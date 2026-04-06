return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "javascript", "typescript", "tsx",
          "html", "css", "json", "lua",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- Ativa folding baseado na estrutura do código
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
