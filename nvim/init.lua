-- Configuration variables
-- buffer configurations
vim.o.number = true
vim.o.relativenumber = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2

-- Text LSPConfig hover on buffer change
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

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
-- Lazy configuration
require("config.lazy")
