-- ~/.config/nvim/plugins/lsp.lua
--
-- LSP TOOLING (Mason)
-- This file manages the installation of language server binaries.
--
-- Mason      → a UI-based installer for language servers, linters, and formatters.
--              Run :Mason to open its interface.
-- mason-lspconfig → bridges Mason and Neovim's LSP system, ensuring the servers
--              listed below are installed automatically on first launch.
-- nvim-lspconfig → required by mason-lspconfig to register server definitions,
--              even though we configure servers in config/lsp.lua.


-- Configuração nativa de LSP (Neovim 0.11+)
vim.lsp.config("ts_ls", {})
vim.lsp.config("html", {})
vim.lsp.config("cssls", {})
vim.lsp.config("emmet_ls", {
  filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
})
vim.lsp.config("jsonls", {})
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } }, -- Não marcar `vim` como global indefinida
    },
  },
})

vim.lsp.enable({ "ts_ls", "html", "cssls", "emmet_ls", "jsonls", "lua_ls" })


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
        "jsonls",    -- JSON
        "lua_ls",    -- Lua
      },
      -- Os servidores já são ligados explicitamente com vim.lsp.enable no topo
      -- deste arquivo; deixar o mason-lspconfig ligar de novo só duplicaria.
      automatic_enable = false,
    },
  },

  -- nvim-lspconfig ainda necessário para registrar os servidores,
  -- mas a configuração agora é feita via vim.lsp.config
  { "neovim/nvim-lspconfig" },
}
