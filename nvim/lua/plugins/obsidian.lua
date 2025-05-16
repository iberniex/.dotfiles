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
    ui = { enable = false },
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
      ["cf"] = {
        action = function()
          return require("obsidian").util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },
    new_notes_location = "current_dir",

    -- Optional, customize how note IDs are generated given an optional title.
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      local randm = ""

      -- random character generation to align with zk-nvim
      for _ = 1, 4 do
        randm = randm .. string.char(math.random(48, 57)) .. string.char(math.random(65, 90)):lower()
      end

      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return randm .. "-" .. tostring(os.date("%Y%m%d")) .. "-" .. suffix
    end,

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { id = note.id, aliases = note.aliases, tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    -- customize how wiki links are formatted
    wiki_link_func = "use_alias_only",

    -- Optional, for templates (see below).
    templates = {
      folder = "~/.config/zk/templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      -- A map for custom variables, the key should be the variable and the value a function
      substitutions = {},
    },
  },
}
