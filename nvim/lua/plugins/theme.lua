return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,

  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      transparent_mode = true,
      italic = {
        strings = true,
        emphasis = true,
        comments = true,
        operators = true,
        folds = true,
      },
    })
    vim.o.background = "dark", vim.cmd([[colorscheme gruvbox]])
  end,
}
