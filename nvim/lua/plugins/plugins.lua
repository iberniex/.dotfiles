return {
	-- this is the tmux-nvim-navigation plugin
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	-- Fuzzy Finder (Telescope)
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependences = { "nvim-lua/plenary.nvim" },
		config = true,
	},

	-- debugging
	{ "mfussenegger/nvim-dap" },

	{
		{ "akinsho/toggleterm.nvim", version = "*", config = true },
	},
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons" },
	{ "echasnovski/mini.nvim", version = "*" },

	-- {
	--     "OXY2DEV/markview.nvim",
	--     lazy = false,
	--
	--     -- For blink.cmp's completion
	--     -- source
	--     -- dependencies = {
	--         --     "saghen/blink.cmp"
	--         -- },
	--     },
	-- {
	--     "nvim-tree/nvim-tree.lua",
	--     version = "*",
	--     lazy = false,
	--     dependencies = {
	--         "nvim-tree/nvim-web-devicons",
	--     },
	--     config = function()
	--         require("nvim-tree").setup {}
	--     end,
	-- },
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"echasnovski/mini.nvim",
			"nvim-tree/nvim-web-devicons",
		}, -- if you use the mini.nvim suite
		---@module 'render-markdown'
		---@type render.md.UserConfig
		opts = {},
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
}
