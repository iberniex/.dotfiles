return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {},
        },
        setup = {
          jdtls = function()
            require("java").setup({})
          end,
        },
      },
    },
  },
}
