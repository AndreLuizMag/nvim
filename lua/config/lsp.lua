-- ~/.config/nvim-mini/lua/config/lsp.lua
--
-- LSP NATIVE ACTIVATION
-- Ativação nativa dos servidores (Neovim 0.11+) e o único keymap que a
-- própria versão do Neovim ainda não cobre por padrão.

-- Capabilities de completion (auto-import via additionalTextEdits, snippets)
-- aplicadas a todos os servidores configurados abaixo
vim.lsp.config("*", { capabilities = MiniCompletion.get_lsp_capabilities() })

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

-- KEYMAPS
-- O Neovim 0.11+ já mapeia por padrão: grn (rename), gra (code action),
-- grr (references), gri (implementation), grt (type definition), gO
-- (document symbols), K (hover) e ]d/[d/]D/[D/<C-w>d (diagnósticos) — ver
-- :h lsp-defaults e :h diagnostic-defaults. Nenhum é reescrito aqui.
-- Único gap real: não existe "gd" nativo (só CTRL-]/tagfunc).
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = args.buf, desc = "Ir para definição" })
  end,
})
