-- ~/.config/nvim/plugins/navigation.lua
--
-- FILE NAVIGATION
-- Two tools for moving around the project:
--
-- neo-tree  → sidebar file explorer (like VS Code's file tree)
--             Shows hidden files (.env) and git-ignored files.
--             Keymap: <Space>e to open/close
--
-- telescope → fuzzy finder for searching files and text
--             Keymaps:
--               <Space>ff → search files by name
--               <Space>fg → search text across the whole project (live grep)
--               <Space>fb → list currently open buffers


return {
  -- File explorer
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        window = {
          position = "left",
          width = 30,
        },
        filesystem = {
          filtered_items = {
            hide_dotfiles = false,     -- Mostra arquivos ocultos como .env
            hide_gitignored = false,   -- Mostra arquivos ignorados pelo git
          },
        },
      })

      -- Atalho para abrir/fechar o explorer
      vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { desc = "Toggle file explorer" })
    end,
  },

  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local telescope = require("telescope")
      telescope.setup({})

      -- Atalhos
      local builtin = require("telescope.builtin")
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Buscar arquivos" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Buscar texto no projeto" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Listar buffers abertos" })
    end,
  },
}
