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
