vim.api.nvim_create_autocmd("FileType", {
  pattern = "man",
  callback = function()
    vim.cmd([[
      hi link manSection Title
      hi link manSubHeading Identifier
      hi link manBold Function
      hi link manUnderline Type
    ]])
  end,
})

-- elixir configurations for .exs extension
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.ex", "*.exs" },
  callback = function()
    vim.bo.filetype = "elixir"
    vim.cmd("TSBufEnable highlight")
  end,
})

-- Lazy configuration
--
require("config.lazy")
