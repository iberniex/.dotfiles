return {

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependences = { "nvim-lua/plenary.nvim" },
    config = true,
  },
  { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
