return {
  "zk-org/zk-nvim",
  config = function()
    require("zk").setup({
      picker = "fzf_lua",
      lsp = {
        config = {
          cmd = { "zk", "lsp" },
          name = "zk",
          on_attach = function()
            require("cmp_nvim_lsp").default_capabilities()
          end,
        },
        auto_attach = {
          enabled = true,
          filetypes = { "markdown" },
        },
      },
    })

    pcall(require, "zk.workspaces")
    pcall(require, "zk.mappings")
  end,
}
