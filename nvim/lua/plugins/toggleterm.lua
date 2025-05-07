return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = nil,
      size = 20,

      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    })

    -- open terminal
    vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", { noremap = true, silent = true })

    -- close terminal during session
    vim.api.nvim_set_keymap("t", "<Esc>", "<C-\\><C-n>", { noremap = true })
  end,
}
