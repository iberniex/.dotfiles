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
        path = {
          fleeting = "~/Documents/vault/001-Fleeting",
          pseudocode = "~/Documents/vault/001-Fleeting/pseudocode",
        },
        template = "fleeting.md",
      },
      literature = {
        name = "literature",
        path = {
          book = "~/Documents/vault/100-Literature/books",
          quote = "~/Documents/vault/100-Literature/quotes",
          person = "~/Documents/vault/100-Literature/person",
          term = "~/Documents/vault/100-Literature/terms",
          tool = "~/Documents/vault/100-Literature/tools",
        },
        template = "literature.md",
      },
      permanent = {
        name = "permanent",
        path = {
          prompt = "~/Documents/vault/200-Permanent",
          question = "~/Documents/vault/200-Permanent",
          permanent = "~/Documents/vault/200-Permanent",
          note = "~/Documents/vault/200-Permanent",
        },
        template = "permanent.md",
      },
    }

    -- Function to create a new note using a template
    function CreateNote(workspace_name)
      local workspace = workspaces[workspace_name]
      if workspace then
        -- literature template creation
        ---@params note_type
        ---@params note_title
        ---@params note_workspace_path
        ---@return table
        if workspace.name == "literature" then
          local note_type = vim.fn.input("Type (book, person, quote, term, tool): ")
          vim.cmd("cd " .. workspace.path[note_type])

          require("zk.commands").get("ZkNew")({
            title = vim.fn.input("Title: "),
            dir = vim.fn.expand(workspace.path[note_type]),
            template = note_type .. ".md",
          })

          -- fleeting template creation
          ---@params note_type
          ---@params note_title
          ---@params note_workspace_path
          ---@return table
        elseif workspace.name == "fleeting" then
          local note_type = vim.fn.input("Type (fleeting, pseudocode): ")
          vim.cmd("cd " .. workspace.path[note_type])

          require("zk.commands").get("ZkNew")({
            title = vim.fn.input("Title: "),
            dir = vim.fn.expand(workspace.path[note_type]),
            template = note_type .. ".md",
          })

          -- Permanent template creation
          ---@params note_type
          ---@params note_title
          ---@params note_workspace_path
          ---@params note_id
          ---@return table
        elseif workspace.name == "permanent" then
          local note_type = vim.fn.input("Type (note, permanent, question, prompt): ")
          vim.cmd("cd " .. workspace.path[note_type])

          require("zk.commands").get("ZkNew")({
            id = vim.fn.input("ID: "),
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
    vim.api.nvim_set_keymap("n", "zf", ":lua CreateNote('fleeting')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "zl", ":lua CreateNote('literature')<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap("n", "zp", ":lua CreateNote('permanent')<CR>", { noremap = true, silent = true })
  end,
}
