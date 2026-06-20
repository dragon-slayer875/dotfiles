return {
	{
	"kawre/leetcode.nvim",
	build = ":TSUpdate html", -- if you have `nvim-treesitter` installed
	dependencies = {
		-- include a picker of your choice, see picker section for more details
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
	},
	opts = {
		-- configuration goes here
		arg = "lc",
		lang = "cpp",
		picker = { provider = "mini-picker" }
	},
},
{
	"dchinmay2/cphelper.nvim",
},
}
