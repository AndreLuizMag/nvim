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
