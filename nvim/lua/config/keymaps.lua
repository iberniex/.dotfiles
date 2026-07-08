-- escape configuration to change from ESC to "jj"
if vim.g.vscode then
  vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })
end

vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- save configuration
-- single save configuration
-- Configuration variables
-- buffer configurations
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.opt.cmdheight = 1
vim.opt.laststatus = 2
vim.o.syntax = "enable"

-- custom keymaps
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.keymap.set("n", "<leader>ww", ":w<CR>", { noremap = true, silent = true })

-- save and quit configuration
vim.keymap.set("n", "<leader>wq", ":wq<CR>", { noremap = true, silent = true, desc = "save and quit" })

-- save all buffers configuration
vim.keymap.set(
  "n",
  "<leader>wa",
  ":wa<CR>",
  { noremap = true, silent = true, desc = "save all files in buffer" }
)

-- quit configuration
vim.keymap.set("n", "<leader>qq", ":q<CR>", { noremap = true, silent = true, desc = "quit" })

vim.keymap.set("n", "<leader>c", function()
  require("mini.bufremove").delete(0, false)
end)

vim.keymap.set("n", "<leader>e", ":Lexplore<CR>", { desc = "Toggle netrw explorer" })
