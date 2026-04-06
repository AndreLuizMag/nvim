-- Configuração nativa de LSP (Neovim 0.11+)
vim.lsp.config("ts_ls", {})
vim.lsp.config("html", {})
vim.lsp.config("cssls", {})
vim.lsp.config("emmet_ls", {
  filetypes = { "html", "css", "scss", "javascriptreact", "typescriptreact" },
})

vim.lsp.enable({ "ts_ls", "html", "cssls", "emmet_ls" })
