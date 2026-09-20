-- ~/.config/nvim-mini/lua/plugins/lsp.lua
--
-- LSP TOOLING (Mason)
-- Specs do lazy.nvim para o LSP. A ativação nativa dos servidores mora em
-- config/lsp.lua — este arquivo só instala os binários e registra os
-- servidores no ecossistema do lspconfig.
--
-- mason.nvim           → instalador de language servers (:Mason)
-- mason-lspconfig.nvim → ponte entre mason e o registro de servidores do lspconfig
-- nvim-lspconfig       → fornece as definições de servidor usadas por vim.lsp.config

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "ts_ls",    -- JavaScript e TypeScript
        "html",     -- HTML
        "cssls",    -- CSS e SCSS
        "emmet_ls", -- Emmet
      },
      -- Os servidores já são ligados explicitamente com vim.lsp.enable em
      -- config/lsp.lua; deixar o mason-lspconfig ligar de novo só duplicaria
      -- (automatic_installation não existe mais na v2 — ver achado 2 do plano).
      automatic_enable = false,
    },
  },
  { "neovim/nvim-lspconfig" },
}
