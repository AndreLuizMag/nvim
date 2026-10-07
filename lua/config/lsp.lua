-- lua/config/lsp.lua
--
-- LSP COMPLETION
-- Built-in LSP completion (:h lsp-completion, :h vim.lsp.completion.enable).
-- Not a plugin: Neovim 0.11+ ships it in the runtime. Servers are configured
-- in lua/plugins/nvim-lspconfig.lua and enabled by mason-lspconfig.
--
-- Without enable() the default omnifunc (<C-x><C-o>) only inserts the plain
-- label; snippets and textEdits (e.g. Emmet `html:5`) are never expanded.
-- With enable(): popup opens automatically on the server's triggerCharacters,
-- first item is pre-selected (completeopt=noinsert), <CR> accepts it and
-- expands snippet / applies text edits. <C-n>/<C-p> move, <C-e> closes.
-- Jump between snippet placeholders with <Tab> / <S-Tab> (runtime default).
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_completion', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

-- <CR> accepts the selected completion item; plain <CR> when no popup is open.
vim.keymap.set('i', '<CR>', function()
  return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
end, { expr = true, desc = 'Accept completion item' })
