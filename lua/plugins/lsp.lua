return {
  -- Gerenciador de language servers
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Ponte entre mason e lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",     -- JavaScript e TypeScript
        "html",      -- HTML
        "cssls",     -- CSS e SCSS
        "emmet_ls",  -- Emmet
      },
      automatic_installation = true,
    },
  },

  -- nvim-lspconfig ainda necessário para registrar os servidores,
  -- mas a configuração agora é feita via vim.lsp.config
  { "neovim/nvim-lspconfig" },
}
