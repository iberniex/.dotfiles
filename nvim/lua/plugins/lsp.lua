-- LSP, Completion, Snippets, Formatting
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "nvimtools/none-ls.nvim",
  },

  config = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local cmp_lsp = require("cmp_nvim_lsp")

    local on_attach = function(client, bufnr)
      vim.opt_local.conceallevel = 2
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ bufnr = bufnr })
          end,
        })
      end
    end

    -- LSP Setup
    -- Javascript/typescript: ts_ls
    vim.lsp.config("ts_ls", {
      capabilities = cmp_lsp.default_capabilities(),
      on_attach = on_attach,
    })
    -- C/C++: Clang
    vim.lsp.config("clangd", {
      capabilities = cmp_lsp.default_capabilities(),
      on_attach = on_attach,
    })

    vim.lsp.config("rust_analyzer", {
      capabilities = cmp_lsp.default_capabilities(),
      settings = {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
            allFeatures = true,
            extraArgs = { "--", "-D", "warnings" },
          },
        },
      },
      on_attach = on_attach,
    })

    -- elixir: elixir-ls
    vim.lsp.config("elixirls", {
      capabilities = cmp_lsp.default_capabilities(),
      cmd = { vim.fn.expand("~/.config/elixir-ls/language_server.sh") },
      on_attach = on_attach,
    })

    -- Markdown: markdown_oxide
    vim.lsp.config("markdown_oxide", {
      capabilities = cmp_lsp.default_capabilities(),
      settings = {
        root_markers = {
          ".moxide.toml",
        },
      },
      on_attach = on_attach,
    })

    -- Yaml: yaml-language-server
    vim.lsp.config("yamlls", {
      capabilities = cmp_lsp.default_capabilities(),
      on_attach = on_attach,
    })

    -- python
    vim.lsp.config("basedpyright", {
      capabilities = cmp_lsp.default_capabilities(),
      on_attach = on_attach,
    })

    -- dotenv: bash, env
    vim.lsp.config("bashls", {
      capabilities = cmp_lsp.default_capabilities(),
      on_attach = on_attach,
    })

    -- Lua: Lua Ls
    vim.lsp.config("lua_ls", {
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
            path = {
              "lua/?.lua",
              "lua/?/init.lua",
            },
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
      on_attach = on_attach,
    })

    vim.lsp.enable({
      "lua_ls",
      "clangd",
      "bashls",
      "basedpyright",
      "yamlls",
      "markdown_oxide",
      "ts_ls",
      "rust_analyzer",
      "elixirls",
    })

    -- none-ls setup
    local null_ls = require("null-ls")
    null_ls.setup({
      sources = {
        -- Lua_Ls
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.selene,

        -- elixir
        null_ls.builtins.diagnostics.credo,
        null_ls.builtins.formatting.mix,

        -- Clangd
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.formatting.clang_format,

        -- Yaml-Language-Server
        null_ls.builtins.diagnostics.yamllint,
        -- null_ls.builtins.formatting.prettierd,

        -- dotenv
        null_ls.builtins.diagnostics.dotenv_linter,
        null_ls.builtins.formatting.shfmt,

        -- python
        null_ls.builtins.diagnostics.pylint,
        null_ls.builtins.formatting.black,
      },
      on_attach = on_attach,
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
