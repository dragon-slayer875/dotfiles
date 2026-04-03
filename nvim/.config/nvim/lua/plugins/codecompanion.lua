return {
	"olimorris/codecompanion.nvim",
	version = "^19.0.0",
	opts = {
		-- NOTE: The log_level is in `opts.opts`
		-- opts = {
		-- 	log_level = "DEBUG",
		-- },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"zbirenbaum/copilot.lua"
	},
}
