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

-- Lazy configuration
require("config.lazy")
