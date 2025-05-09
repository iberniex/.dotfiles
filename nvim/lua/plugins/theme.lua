return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,

  config = function()
    require("gruvbox").setup({
      terminal_colors = true,
      transparent_mode = true,
      italic = {
        strings = false,
        emphasis = false,
        comments = true,
        operators = false,
        folds = false,
      },
    })
    vim.o.background = "dark", vim.cmd([[colorscheme gruvbox]])
  end,
}
