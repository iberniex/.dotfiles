local bridge_settings = {
	obsidian_server_address = "https://127.0.0.1:27124",
	scroll_sync = false,
	cert_path = "~/.ssl/obsidian.crt",
	warnings = true,
	picker = "telescope",
}


return {
	"oflisback/obsidian-bridge.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  -- dependencies = { "ibhagwan/fzf-lua" }, -- For picker = "fzf_lua"
  opts = bridge_settings,
  event = {
    "BufReadPre *.md",
    "BufNewFile *.md",
  },
  lazy = false,
}

