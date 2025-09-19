local notes = require("zk.notes")

local M = {}

local opts = { noremap = true, silent = true }

-- table of mappings: { mode, lhs, rhs, desc }
local maps = {
  {
    "n",
    "zf",
    function()
      notes.create_note("fleeting", "ZkNew")
    end,
    "Create fleeting note",
  },
  {
    "n",
    "zl",
    function()
      notes.create_note("literature", "ZkNew")
    end,
    "Create literature note",
  },
  {
    "n",
    "zp",
    function()
      notes.create_note("permanent", "ZkNew")
    end,
    "Create permanent note",
  },
  {
    "n",
    "<leader>zp",
    function()
      notes.create_note("project", "ZkNew")
    end,
    "Create project note",
  },
  {
    "n",
    "zi",
    function()
      notes.create_note("index", "ZkNew")
    end,
    "Create index note",
  },

  {
    "v",
    "zft",
    function()
      notes.create_note("fleeting", "ZkNewFromTitleSelection")
    end,
    "Fleeting: title selection",
  },
  {
    "v",
    "zlt",
    function()
      notes.create_note("literature", "ZkNewFromTitleSelection")
    end,
    "Literature: title selection",
  },
  {
    "v",
    "zfc",
    function()
      notes.create_note("fleeting", "ZkNewFromContentSelection")
    end,
    "Fleeting: content selection",
  },
  {
    "v",
    "zlc",
    function()
      notes.create_note("literature", "ZkNewFromContentSelection")
    end,
    "Literature: content selection",
  },

  -- Direct Ex commands
  { "n", "<leader>znl", "<cmd>ZkNotes<CR>", "Zk: list all notes" },
  { "n", "<leader>znb", "<cmd>ZkBuffers<CR>", "Zk: list note buffers" },
  { "n", "<leader>zbl", "<cmd>ZkBacklinks<CR>", "Zk: list backlinks" },
  { "n", "<leader>zll", "<cmd>ZkLinks<CR>", "Zk: list links in buffer" },
  { "v", "zm", "<cmd>ZkMatch<CR>", "Zk: match search" },
  { "n", "zt", "<cmd>ZkTags<CR>", "Zk: list tags" },
  { "n", "zcd", "<cmd>ZkCd<CR>", "Zk: go to root directory" },
  { "n", "<leader>zlk", "<cmd>ZkInsertLink<CR>", "Zk: insert link at cursor" },
  { "v", "<leader>zik", "<cmd>ZkInsertLinkAtSelection<CR>", "Zk: insert link at selection" },
}

-- Apply mappings with vim.keymap.set
for _, m in ipairs(maps) do
  local mode, lhs, rhs, desc = unpack(m)
  ---@diagnostic disable-next-line: param-type-mismatch
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

M.maps = maps
return M
