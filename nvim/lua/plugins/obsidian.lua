return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = false,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
    -- refer to `:h file-pattern` for more examples
    "BufReadPre "
      .. vim.fn.expand("~")
      .. "Documents/vault/*.md",
    "BufNewFile  " .. vim.fn.expand("~") .. "Documents/vault/*.md",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-telescope/telescope.nvim",
    "nvim-treesitter/nvim-treesitter",
  },

  opts = {
    workspaces = {
      {
        name = "fleeting",
        path = "~/Documents/vault/001-Fleeting",
      },
      {
        name = "literature",
        path = "~/Documents/vault/100-Literature",
      },
      {
        name = "literature",
        path = "~/Documents/vault/000-Index",
      },
      {
        name = "permanent",
        path = "~/Documents/vault/200-Permanent",
      },
    },
  },

  -- default folder for notes
  notes_subdir = "000-Index",

  -- auto completion with cmp
  completion = {
    nvim_cmp = true,
    min_chars = 2,
  },

  -- setting the log level for obsidian.nvim
  log_level = vim.log.levels.INFO,

  -- default mappings
  mappings = {
    -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
    ["gf"] = {
      action = function()
        return require("obsidian").util.gf_passthrough()
      end,
      opts = { noremap = false, expr = true, buffer = true },
    },
    -- Toggle check-boxes.
    ["<leader>ch"] = {
      action = function()
        return require("obsidian").util.toggle_checkbox()
      end,
      opts = { buffer = true },
    },
    -- Smart acion depending on context, either follow link or toggle checkbox.
    ["<leader>cf"] = {
      action = function()
        return require("obsidian").util.smart_action()
      end,
      opts = { buffer = true, expr = true },
    },
  },
  new_notes_location = "000-Index",
}
