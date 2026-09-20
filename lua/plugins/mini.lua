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
    end,
  },
}
