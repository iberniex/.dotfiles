return { 
"EdenEast/nightfox.nvim",
config = function()
	require("nightfox").setup({

		options = {
			transparent = true,
			terminal_colors = true,
			dim_inactive = true,

			styles = {
				keywords = "bold",
				types = "italic, bold"
			},
		},
	})
	vim.cmd("colorscheme carbonfox")
end,
}
