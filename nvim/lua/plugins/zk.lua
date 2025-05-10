return {
  "zk-org/zk-nvim",
  config = function()
    require("zk").setup({
      picker = "fzf_lua",

      lsp = {
        -- `config` is passed to `vim.lsp.start_client(config)`
        config = {
          cmd = { "zk", "lsp" },
          name = "zk",
          -- etc, see `:h vim.lsp.start_client()`
        },

        -- automatically attach buffers in a zk notebook that match the given filetypes
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      },
    })

    -- Define workspaces and templates
    local workspaces = {
      fleeting = {
        name = "fleeting",
        path = "~/Documents/vault/fleeting",
        template = "fleeting.md",
      },
      literature = {
        name = "literature",
        path = {
          book = "~/Documents/vault/literature/books",
          quote = "~/Documents/vault/literature/quotes",
          person = "~/Documents/vault/literature/person",
          literature = "~/Documents/vault/literature/lit",
        },
        template = "literature.md",
      },
      permanent = {
        name = "permanent",
        path = "~/Documents/vault/permanent",
        template = "permanent.md",
      },
    }

    -- Function to create a new note using a template
    function CreateNote(workspace_name)
      local workspace = workspaces[workspace_name]
      if workspace then
        if workspace.name == "literature" then
          local note_type = vim.fn.input("Type: ")
          vim.cmd("cd " .. workspace.path[note_type])

          print(note_type .. ".md")
          print(workspace.path[note_type])
          require("zk.commands").get("ZkNew")({
            title = vim.fn.input("Title: "),
            dir = vim.fn.expand(workspace.path[note_type]),
            template = note_type .. ".md",
          })
        else
          vim.cmd("cd " .. workspace.path)
          require("zk.commands").get("ZkNew")({
            title = vim.fn.input("Title: "),
            dir = vim.fn.expand(workspace.path),
            template = workspace.template,
          })
        end
      else
        print("Workspace not found: " .. workspace_name)
      end
    end

    -- Keymaps for creating new notes with templates
    vim.api.nvim_set_keymap(
      "n",
      "<leader>zf",
      ":lua CreateNote('fleeting')<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>zl",
      ":lua CreateNote('literature')<CR>",
      { noremap = true, silent = true }
    )
    vim.api.nvim_set_keymap(
      "n",
      "<leader>zp",
      ":lua CreateNote('permanent')<CR>",
      { noremap = true, silent = true }
    )
  end,
}
