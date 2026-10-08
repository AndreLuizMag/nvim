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
-- first item is pre-selected (completeopt=noinsert). <C-n>/<C-p> move, <C-e>
-- closes. <CR> is left untouched (always a plain newline, see :h i_<CR>).
--
-- `convert` (:h vim.lsp.completion.enable()) rewrites the popup columns per
-- item. Emmet sends no CompletionItemKind, so Neovim's own default converter
-- falls back to the literal "Unknown" for every abbreviation, even though it
-- parsed it correctly (the preview window already shows the right expansion).
-- Only the first client to attach to a buffer gets its `convert` kept, so it
-- must stay generic for every server, not just Emmet — hence the `item.detail`
-- check before touching anything.
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp_completion', { clear = true }),
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client and client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {
        autotrigger = true,
        convert = function(item)
          if item.detail == 'Emmet Abbreviation' then
            return { kind = 'Emmet', menu = '' }
          end
          return {}
        end,
      })
    end
  end,
})

-- <Tab>: accept the selected completion item (expands snippet / applies text
-- edits, same as <C-y>) when the popup is visible; otherwise jump to the next
-- snippet placeholder (:h vim.snippet.jump) when one is active; otherwise a
-- plain Tab. <S-Tab> keeps the runtime default (jump to the previous
-- placeholder, :h vim.snippet-mappings), since nothing here overrides it.
vim.keymap.set('i', '<Tab>', function()
  if vim.fn.pumvisible() == 1 then
    return '<C-y>'
  end
  if vim.snippet.active({ direction = 1 }) then
    vim.snippet.jump(1)
    return ''
  end
  return '<Tab>'
end, { expr = true, desc = 'Accept completion item or jump to next snippet placeholder' })
