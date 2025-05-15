-- Configuration variables
--

-- buffer configurations
vim.o.number = true
vim.o.relativenumber = true
vim.o.autoindent = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- Lazy configuration
require("config.lazy")

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

vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })

-- Text LSPConfig hover on buffer change
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = true,
})

-- lsp enables
vim.lsp.enable("lua_ls")
