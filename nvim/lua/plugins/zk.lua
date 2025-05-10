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
          on_attach = true,
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
        path = "~/Documents/vault/fleeting",
        template = "fleeting.md",
      },
      literature = {
        path = "~/Documents/vault/literature",
        template = "literature.md",
      },
      permanent = {
        path = "~/Documents/vault/permanent",
        template = "permanent.md",
      },
    }

    -- Function to create a new note using a template
    function CreateNote(workspace_name)
      local workspace = workspaces[workspace_name]
      if workspace then
        vim.cmd("cd " .. workspace.path)
        require("zk.commands").get("ZkNew")({
          title = vim.fn.input("Title: "),
          dir = vim.fn.expand(workspace.path),
          template = workspace.template,
        })
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
