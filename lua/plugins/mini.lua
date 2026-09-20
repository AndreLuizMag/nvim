-- ~/.config/nvim-mini/lua/plugins/mini.lua
--
-- MINI.NVIM MODULES
-- Todos os módulos habilitados do mini.nvim entram aqui, em seções, a
-- partir da Etapa 2.

return {
  {
    "nvim-mini/mini.nvim",
    version = false,   -- branch `main` (desenvolvimento), conforme recomendação do projeto
    lazy = false,
    priority = 1000,   -- carrega antes de tudo: o colorscheme vem daqui
    config = function()
      -- módulos entram nas etapas seguintes
    end,
  },
}
