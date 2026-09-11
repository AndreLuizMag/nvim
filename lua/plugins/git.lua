-- ~/.config/nvim/plugins/git.lua
--
-- GIT INTEGRATION
-- mini.diff → shows how the current buffer differs from its git index version.
--             Changed lines are marked, and each block of changes (a "hunk")
--             can be staged or reverted without leaving the editor.
--
--             The reference text comes from git by default (requires git 2.38+).
--             Staging works; unstaging does not — use the git CLI for that.
--
--             Keymaps:
--               ]h / [h     → jump to the next / previous hunk
--               ]H / [H     → jump to the last / first hunk
--               gh          → apply (stage) a hunk — operator, e.g. ghgh for the current one
--               gH          → reset a hunk to the reference — operator, e.g. gHgH
--               gh          → also a text object in visual/operator mode (e.g. vgh)
--               <leader>gd  → toggle the inline overlay with the full diff


return {
  {
    "nvim-mini/mini.diff",
    version = "*",  -- Stable branch, conforme recomendado pela documentação
    config = function()
      local diff = require("mini.diff")

      diff.setup({
        view = {
          -- O default é "sign" aqui: ele depende de vim.go.number, e o init.lua
          -- carrega config.lazy — ou seja, este setup — antes de config.options,
          -- então 'number' ainda está desligado neste ponto. Fixado explicitamente
          -- pra não virar "number" caso essa ordem mude.
          style = "sign",

          -- O default é "▒", um bloco que preenche a célula inteira. "▏" (left one
          -- eighth block) desenha só uma barra fina na borda esquerda.
          signs = { add = "▏", change = "▏", delete = "▏" },
        },
      })

      -- O overlay não tem mapping default na documentação
      vim.keymap.set("n", "<leader>gd", diff.toggle_overlay, { desc = "Toggle git diff overlay" })
    end,
  },
}
