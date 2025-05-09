-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- escape configuration to change from ESC to "jj"
vim.keymap.set("i", "jj", "<Esc>", { noremap = true, silent = true })

-- save configuration
-- single save configuration
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
-- Setup lazy.nvim
require("lazy").setup({
  spec = {
    -- import your plugins
    { import = "plugins" },
  },

  -- automatically check for plugin updates
  checker = { enabled = true },
})
