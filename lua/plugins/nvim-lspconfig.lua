-- nvim-lspconfig — https://github.com/neovim/nvim-lspconfig
-- Coleção de definições de servidores LSP (cmd, filetypes, root_markers) em `lsp/`.
-- Não precisa de setup(); Neovim 0.11+ lê via vim.lsp.config / vim.lsp.enable.
-- Quem liga os servidores é o mason-lspconfig (ver mason-lspconfig.lua).

-- lua_ls: reconhecer `vim` e runtime do Neovim ao editar esta config
vim.lsp.config('lua_ls', {
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
        path ~= vim.fn.stdpath('config')
        and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
      then
        return
      end
    end
    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = { version = 'LuaJIT', path = { 'lua/?.lua', 'lua/?/init.lua' } },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    })
  end,
  settings = { Lua = {} },
})

-- html: formatador (gq / vim.lsp.buf.format) quebra texto longo em 80 colunas,
-- alinhado ao colorcolumn. Padrão do servidor é 120. Só quebra texto; tags
-- com muitos atributos ficam intactas.
vim.lsp.config('html', {
  settings = { html = { format = { wrapLineLength = 80 } } },
})
