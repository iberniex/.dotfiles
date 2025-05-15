return {

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependences = { "nvim-lua/plenary.nvim" },
    config = function()
      -- Telescope configuration

      require("telescope").setup({
        pickers = {
          find_files = {
            theme = "dropdown",
          },
        },
      })

      -- telescope-fxf-ext loading_extension
      require("telescope").load_extension("fzf")

      -- telescope keybinds
      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", ":Telescope find_files<cr>", { desc = "telescope find files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "telescope live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "telescope buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "telescope help tags" })
    end,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
