-- Configuration variables
--

-- buffer configurations
vim.o.number = true
vim.o.relativenumber = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.spelllang = "en_us"

-- Lazy configuration
require("config.lazy")

-- Text LSPConfig hover on buffer change
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})
