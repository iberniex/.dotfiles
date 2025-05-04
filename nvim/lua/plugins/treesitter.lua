return {
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/nvim-treesitter-refactor",
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "c", "lua", "vim", "vimdoc", "query" },
		highlight = { enable = true },
		refactor = {
			highlight_definitions = {
				enable = true,

				-- clear the definition during cursor move
				clear_on_cursor_move = true,
			},
			highlight_current_scope ={ enable = true },
		},
		indent = { 
			enable = true,
		},
		config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
},
}
