-- ~/.config/nvim-mini/lua/plugins/mini.lua
--
-- MINI.NVIM MODULES
-- Todos os módulos habilitados do mini.nvim entram aqui, em seções, à
-- medida que as etapas da migração avançam.

return {
  {
    "nvim-mini/mini.nvim",
    version = false,   -- branch `main` (desenvolvimento), conforme recomendação do projeto
    lazy = false,
    priority = 1000,   -- carrega antes de tudo: o colorscheme vem daqui
    dependencies = { "rafamadriz/friendly-snippets" }, -- só fonte de dados JSON para mini.snippets
    config = function()
      -- COLORSCHEME
      -- miniwinter: paleta azulada baseada em mini.hues, a mais próxima em
      -- temperatura do Adwaita claro usado antes. Sem setup() próprio.
      vim.cmd.colorscheme("miniwinter")

      -- ICONS
      require("mini.icons").setup()
      -- Deixa plugins que só suportam nvim-web-devicons funcionarem sem
      -- esse repositório instalado
      MiniIcons.mock_nvim_web_devicons()

      -- STATUSLINE
      require("mini.statusline").setup()

      -- TABLINE
      require("mini.tabline").setup()

      -- NOTIFY
      -- setup() já redireciona vim.notify() por conta própria (chama
      -- MiniNotify.make_notify() internamente) — nada manual precisa ser feito
      require("mini.notify").setup()

      -- INDENTSCOPE
      require("mini.indentscope").setup()

      -- HIPATTERNS
      -- setup() vazio não define nenhum highlighter (comportamento documentado).
      -- Único highlighter desta etapa: cor hex (#rrggbb) destacada na própria cor.
      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = {
          hex_color = hipatterns.gen_highlighter.hex_color(),
        },
      })

      -- FILES
      require("mini.files").setup()

      -- PICK
      require("mini.pick").setup()

      -- EXTRA
      -- Registra pickers adicionais (buf_lines, diagnostic, git_*, etc.) em
      -- MiniPick.registry, disponíveis via :Pick <nome>. Nenhum é mapeado
      -- diretamente nesta etapa.
      require("mini.extra").setup()

      -- SNIPPETS
      -- Precisa vir antes de mini.completion: o default_snippet_insert do
      -- mini.completion só usa mini.snippets se ele já estiver com setup()
      -- feito no momento da inserção.
      local gen_loader = require("mini.snippets").gen_loader
      require("mini.snippets").setup({
        snippets = {
          -- friendly-snippets não lê 1:1 por filetype nem expõe seu
          -- package.json para o mini.snippets — os caminhos abaixo replicam
          -- manualmente o mapeamento real do package.json dele para os
          -- filetypes do stack de front-end (JS/TS/React, HTML, CSS/SCSS).
          gen_loader.from_lang({
            lang_patterns = {
              javascript = { "javascript/javascript.json" },
              typescript = { "javascript/typescript.json" },
              javascriptreact = {
                "javascript/javascript.json",
                "javascript/react.json",
                "javascript/react-es7.json",
                "javascript/next.json",
                "html.json",
              },
              typescriptreact = {
                "javascript/typescript.json",
                "javascript/react-ts.json",
                "javascript/react-es7.json",
                "javascript/next-ts.json",
                "html.json",
              },
              html = { "html.json" },
              css = { "css.json" },
              scss = { "css.json" }, -- friendly-snippets não tem scss.json separado
            },
          }),
        },
      })
      -- Expõe os snippets carregados dentro do popup de completion (não só via <C-j> direto)
      MiniSnippets.start_lsp_server()

      -- COMPLETION
      require("mini.completion").setup()

      -- KEYMAPS — navegação
      -- Preserva a memória muscular de neo-tree/telescope, com dois atalhos
      -- novos (fh, fr) e um resolvendo um gap conhecido da main (fs).
      vim.keymap.set("n", "<leader>e", MiniFiles.open, { desc = "Abrir explorador de arquivos" })
      vim.keymap.set("n", "<leader>ff", MiniPick.builtin.files, { desc = "Buscar arquivos" })
      vim.keymap.set("n", "<leader>fg", MiniPick.builtin.grep_live, { desc = "Buscar texto no projeto" })
      vim.keymap.set("n", "<leader>fb", MiniPick.builtin.buffers, { desc = "Listar buffers abertos" })
      vim.keymap.set("n", "<leader>fh", MiniPick.builtin.help, { desc = "Buscar help tags" })
      vim.keymap.set("n", "<leader>fr", MiniPick.builtin.resume, { desc = "Retomar último picker" })
      vim.keymap.set("n", "<leader>fs", function()
        MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") })
      end, { desc = "Buscar palavra sob o cursor no projeto" })
    end,
  },
}
