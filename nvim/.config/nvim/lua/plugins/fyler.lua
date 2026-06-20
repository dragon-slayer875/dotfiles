return {
	"FylerOrg/fyler.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		integrations = {
			icon = "nvim_web_devicons",
		},
		extensions = {
			git = {
				enabled = true,
				inline = false,
			},
		},
	  mappings = {
		n = {
		  ['<BS>'] = { action = 'visit', args = { parent = true } },
		},
	  },
	},
	keys = {
		{
			"<leader>e",
			function()
				require("fyler").toggle({ kind = "split_right_most" })
			end,
			desc = "Toggle File Explorer"
		},
	}
}
