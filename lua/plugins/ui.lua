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
          enabled = true,  -- Destaca o escopo atual
        },
      })
    end,
  },
}
