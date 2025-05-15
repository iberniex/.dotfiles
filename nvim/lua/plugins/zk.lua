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
    function CreateNote(workspace_name, type)
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

          -- -- type checker to split title creation
          if type == "ZkNewFromTitleSelection" or type == "ZkNewFromContentSelection" then
            require("zk.commands").get(type)({
              dir = vim.fn.expand(workspace.path[note_type]),
              template = note_type .. ".md",
            })
          else
            require("zk.commands").get(type)({
              title = vim.fn.input("Title: "),
              dir = vim.fn.expand(workspace.path[note_type]),
              template = note_type .. ".md",
            })
          end

          -- fleeting template creation
          ---@params note_type
          ---@params note_title
          ---@params note_workspace_path
          ---@return table
        elseif workspace.name == "fleeting" then
          local note_type = vim.fn.input("Type (fleeting, pseudocode): ")
          vim.cmd("cd " .. workspace.path[note_type])

          -- type checker for split title and content creation
          if type == "ZkNewFromTitleSelection" or type == "ZkNewFromContentSelection" then
            require("zk.commands").get(type)({
              dir = vim.fn.expand(workspace.path[note_type]),
              template = note_type .. ".md",
            })
          else
            require("zk.commands").get(type)({
              title = vim.fn.input("Title: "),
              dir = vim.fn.expand(workspace.path[note_type]),
              template = note_type .. ".md",
            })
          end

          -- Permanent template creation
          ---@params note_type
          ---@params note_title
          ---@params note_workspace_path
          ---@params note_id
          ---@return table
        elseif workspace.name == "permanent" then
          local note_type = vim.fn.input("Type (note, permanent, question, prompt): ")
          vim.cmd("cd " .. workspace.path[note_type])
          local title = vim.fn.input("Title: ")
          local id = vim.fn.input("ID: ")
          local cmd =
            string.format("~/.config/nvim/lua/scripts/zk-new-permanent.sh %q %q %q", title, id, note_type)
          local output = vim.fn.system(cmd) -- Trim whitespace
          local filepath = vim.fn.trim(output)

          -- Open the file
          if vim.fn.filereadable(filepath) == 1 then
            vim.cmd("edit " .. filepath)
          else
            print("Could not find the created file: " .. filepath)
          end
        else
          print("Workspace not found: " .. workspace_name)
        end
      end
    end

    local maps = { noremap = true, silent = true }

    -- Keymaps for creating new notes with templates
    -- Note creation from terminal
    vim.api.nvim_set_keymap("n", "zf", ":lua CreateNote('fleeting', 'ZkNew')<CR>", maps)
    vim.api.nvim_set_keymap("n", "zl", ":lua CreateNote('literature', 'ZkNew')<CR>", maps)
    vim.keymap.set("n", "zp", ":lua CreateNote('permanent', 'ZkNew')<CR>", maps)

    -- note creation from selection:title
    vim.api.nvim_set_keymap("v", "zft", ":lua CreateNote('fleeting', 'ZkNewFromTitleSelection')<CR>", maps)
    vim.api.nvim_set_keymap("v", "zlt", ":lua CreateNote('literature', 'ZkNewFromTitleSelection')<CR>", maps)

    -- note creation from selection:content
    vim.api.nvim_set_keymap("v", "zfc", ":lua CreateNote('fleeting', 'ZkNewFromContentSelection')<CR>", maps)
    vim.api.nvim_set_keymap(
      "v",
      "zlc",
      ":lua CreateNote('literature', 'ZkNewFromContentSelection')<CR>",
      maps
    )

    -- picker options
    vim.api.nvim_set_keymap("n", "<leader>zff", ":ZkNotes<CR>", maps)
    vim.api.nvim_set_keymap("n", "<leader>zfb", ":ZkBuffers<CR>", maps)
    vim.api.nvim_set_keymap("n", "<leader>zbl", ":ZkBacklinks<CR>", maps)
    vim.api.nvim_set_keymap("n", "<leader>zll", ":ZkLinks<CR>", maps)
    vim.api.nvim_set_keymap("v", "zm", ":ZkMatch<CR>", maps)
    vim.api.nvim_set_keymap("n", "zt", ":ZkTags<CR>", maps)
    vim.api.nvim_set_keymap("n", "zcd", ":ZkCd<CR>", maps)
    -- link usage
    vim.api.nvim_set_keymap("n", "zll", ":ZkInsertLink<CR>", maps)
    vim.api.nvim_set_keymap("v", "zil", ":ZkInsertLinkAtSelection {matchSelected = true}<CR>", maps)
  end,
}
