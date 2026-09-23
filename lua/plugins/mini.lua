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

      -- GANHO PASSIVO (não exige hábito novo, melhora o que já se faz)
      require("mini.ai").setup()
      require("mini.pairs").setup()
      require("mini.surround").setup()

      -- EXIGE HÁBITO NOVO (usuário precisa aprender os mappings)
      require("mini.operators").setup({
        -- Default usa "gr" e remove a família nativa gra/gri/grn/grr/grt/grx
        -- do LSP (Etapa 4); "cr" preserva os 6 mappings nativos intactos.
        replace = { prefix = "cr" },
      })
      require("mini.splitjoin").setup()
      require("mini.move").setup()
      require("mini.bracketed").setup({
        -- mini.indentscope já cobre [i/]i com mais recursos (Etapa 2);
        -- a própria doc do mini.bracketed recomenda desabilitar aqui.
        indent = { suffix = "" },
      })

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

      -- DIFF
      local diff = require("mini.diff")
      diff.setup({
        view = {
          -- O default depende de vim.go.number, mas config.lazy roda antes de
          -- config.options — nesse momento 'number' ainda está no valor de
          -- fábrica (false), então o default calculado já seria "sign" mesmo.
          -- Fixado explicitamente pra não virar "number" se a ordem dos
          -- requires do init.lua mudar (mesmo raciocínio já usado no git.lua
          -- de main/new-setup para este módulo).
          style = "sign",
          -- Default é "▒" (bloco cheio); "▏" desenha só uma barra fina na
          -- borda esquerda — reaproveitando a escolha já em uso em main.
          signs = { add = "▏", change = "▏", delete = "▏" },
        },
      })
      -- O overlay não tem mapping default na documentação
      vim.keymap.set("n", "<leader>gd", diff.toggle_overlay, { desc = "Alternar overlay de diff" })

      -- GIT
      -- Popula vim.b.minigit_summary_string em todo buffer normal; a seção de
      -- branch da mini.statusline (Etapa 2) já consome isso automaticamente,
      -- sem precisar de nenhuma configuração extra aqui.
      require("mini.git").setup()

      -- CLUE
      -- Precisa vir por último entre os módulos que usam prefixo "g" (mini.ai,
      -- mini.operators, mini.bracketed da Etapa 7): os triggers do mini.clue
      -- devem ser os mapeamentos mais recentes desses prefixos.
      local miniclue = require("mini.clue")
      miniclue.setup({
        triggers = {
          { mode = { "n", "x" }, keys = "<Leader>" },
          { mode = "n", keys = "[" },
          { mode = "n", keys = "]" },
          { mode = "i", keys = "<C-x>" },
          { mode = { "n", "x" }, keys = "g" },
          { mode = { "n", "x" }, keys = "'" },
          { mode = { "n", "x" }, keys = "`" },
          { mode = { "n", "x" }, keys = '"' },
          { mode = { "i", "c" }, keys = "<C-r>" },
          { mode = "n", keys = "<C-w>" },
          { mode = { "n", "x" }, keys = "z" },
        },
        clues = {
          -- Único grupo <leader> real desta config (ver achado 5 — <leader>r
          -- e <leader>c da Etapa 4 não existem, mantivemos o LSP nativo)
          { mode = "n", keys = "<Leader>f", desc = "+Find/Buscar" },
          miniclue.gen_clues.square_brackets(),
          miniclue.gen_clues.builtin_completion(),
          miniclue.gen_clues.g(),
          miniclue.gen_clues.marks(),
          miniclue.gen_clues.registers(),
          miniclue.gen_clues.windows(),
          miniclue.gen_clues.z(),
        },
      })
    end,
  },
}
