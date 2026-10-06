-- mason-lspconfig.nvim — https://github.com/mason-org/mason-lspconfig.nvim
-- Ponte mason <-> nvim-lspconfig: traduz nomes (vtsls -> pacote Mason),
-- instala o que falta (ensure_installed) e liga via vim.lsp.enable().
-- Lista explícita em automatic_enable evita ligar pacotes antigos do Mason.
local servers = {
  'lua_ls',                 -- Lua
  'vtsls',                  -- JavaScript / TypeScript / TSX
  'html',                   -- HTML
  'cssls',                  -- CSS / SCSS / Less
  'jsonls',                 -- JSON
  'emmet_language_server',  -- Emmet (html/css/scss/jsx/tsx)
  'tailwindcss',            -- Tailwind (só ativa com tailwind.config.*)
}

require('mason-lspconfig').setup({
  ensure_installed = servers,
  automatic_enable = servers,
})
