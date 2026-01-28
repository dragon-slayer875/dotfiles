return {
	"A7Lavinraj/fyler.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = {
		integrations = {
			icon = "nvim_web_devicons",
		},
		views = {
			finder = {
				default_explorer = true,
				mappings = {
					["<BS>"] = "GotoParent",
					["^"] = "CollapseNode",
				},
			}
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
