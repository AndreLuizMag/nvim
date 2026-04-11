-- ~/.config/nvim/plugins/completion.lua
--
-- AUTOCOMPLETION
-- Sets up the autocomplete menu that appears while you type.
--
-- nvim-cmp    → the completion engine (shows the popup menu)
-- LuaSnip     → snippet engine (expands shortcuts like "div<Tab>" into full HTML)
-- friendly-snippets → a collection of ready-made snippets for many languages
--
-- Sources (what feeds suggestions into the menu, in priority order):
--   nvim_lsp  → suggestions from the active language server
--   luasnip   → snippet completions
--   buffer    → words already present in the current file
--   path      → file system paths
--
-- Key bindings:
--   <C-Space>  → open the menu manually
--   <C-e>      → close the menu
--   <CR>       → confirm the selected suggestion
--   <Tab>      → move down / expand snippet
--   <S-Tab>    → move up / jump back in snippet


return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        dependencies = {
          "rafamadriz/friendly-snippets",
        },
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),       -- Abre o menu manualmente
          ["<C-e>"]     = cmp.mapping.abort(),          -- Fecha o menu
          ["<CR>"]      = cmp.mapping.confirm({ select = true }), -- Confirma a sugestão
          ["<Tab>"]     = cmp.mapping(function(fallback) -- Navega para baixo
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"]   = cmp.mapping(function(fallback) -- Navega para cima
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
