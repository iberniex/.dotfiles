return {
  "akinsho/toggleterm.nvim",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<leader>tt]],
      size = 20,

      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 3,
      },
    })

    -- close terminal during session
    vim.api.nvim_set_keymap("t", "<leader><Esc>", "<C-\\><C-n>:q!<CR>", { noremap = true, silent = true })
  end,
}
