-- LSP, Completion, Snippets, Formatting
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "nvimtools/none-ls.nvim",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    {
      "folke/neodev.nvim",
      config = true, -- This auto-injects Neovim runtime types into lua_ls
    },
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "clangd", "lua_ls", "bashls", "yamlls" },
    })

    require("neodev").setup({})

    local lspconfig = require("lspconfig")
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local cmp_lsp = require("cmp_nvim_lsp")

    -- LSP Setup
    -- C/C++: Clang
    lspconfig.clangd.setup({
      capabilities = cmp_lsp.default_capabilities(),
    })

    -- Markdown: markdown_oxide
    lspconfig.markdown_oxide.setup({
      capabilities = vim.tbl_deep_extend("force", cmp_lsp.default_capabilities(), {
        workspace = {
          didChangeWatchedFiles = {
            dynamicRegistration = true,
          },
        },
      }),
    })

    -- Yaml: yaml-language-server
    lspconfig.yamlls.setup({
      capabilities = cmp_lsp.default_capabilities(),
    })

    --
    -- dotenv: bash, env
    lspconfig.bashls.setup({})

    -- Lua: Lua Ls
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          runtime = {
            version = "Lua51",
            path = vim.split(package.path, ";"),
          },
          diagnostics = {
            globals = { "vim", "use", "describe", "it", "before_each", "after_each" },
          },
          workspace = {
            library = {
              vim.env.VIMRUNTIME,
              vim.fn.stdpath("config"),
            },
            checkThirdParty = true,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    -- none-ls setup
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Lua_Ls
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.selene.with({
          condition = function(utils)
            return utils.root_has_file({ "selene.toml", "selene.yaml" })
          end,
        }),

        -- Clangd
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.formatting.clang_format,

        -- Yaml-Language-Server
        null_ls.builtins.diagnostics.yamllint,
        -- null_ls.builtins.formatting.prettierd,

        -- dotenv
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.formatting.shfmt,
      },
      on_attach = function(client, bufnr)
        -- If you want formatting on save
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
    })
    -- CMP Setup
    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<Tab>"] = cmp.mapping.select_next_item(),
        ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
      },
    })
  end,
}
