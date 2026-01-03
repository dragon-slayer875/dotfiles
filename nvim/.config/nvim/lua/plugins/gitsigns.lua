return {
	'lewis6991/gitsigns.nvim',
	opts = {
		signs = {
			add = { text = '▎' },
			change = { text = '▎' },
			delete = { text = '▎' },
			topdelete = { text = '▎' },
			changedelete = { text = '▎' },
		},
		status_formatter = function(status)
			local added, changed, removed = status.added, status.changed, status.removed
			local status_txt = {}
			if added and added > 0 then
				local added_status = string.format('%%#%s# %s%%*', 'diffAdded', added)
				table.insert(status_txt, added_status)
			end
			if changed and changed > 0 then
				local changed_status = string.format('%%#%s# %s%%*', 'diffChanged', changed)
				table.insert(status_txt, changed_status)
			end
			if removed and removed > 0 then
				local removed_status = string.format('%%#%s# %s%%*', 'diffRemoved', removed)
				table.insert(status_txt, removed_status)
			end
			return table.concat(status_txt, ' ')
		end,
		on_attach = function(bufnr)
			local gitsigns = require 'gitsigns'

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			-- Navigation
			map('n', ']h', function()
				if vim.wo.diff then
					vim.cmd.normal { ']h', bang = true }
				else
					gitsigns.nav_hunk 'next'
				end
			end, { desc = 'Jump to next [h]unk' })

			map('n', '[h', function()
				if vim.wo.diff then
					vim.cmd.normal { '[h', bang = true }
				else
					gitsigns.nav_hunk 'prev'
				end
			end, { desc = 'Jump to previous git [h]unk' })

			-- Actions
			-- visual mode
			map('v', '<leader>gs', function()
				gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
			end, { desc = '[s]tage hunk' })
			map('v', '<leader>gr', function()
				gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
			end, { desc = '[r]eset hunk' })
			-- normal mode
			map('n', '<leader>gs', gitsigns.stage_hunk, { desc = '[s]tage hunk' })
			map('n', '<leader>gr', gitsigns.reset_hunk, { desc = '[r]eset hunk' })
			map('n', '<leader>gS', gitsigns.stage_buffer, { desc = '[S]tage buffer' })
			map('n', '<leader>gu', gitsigns.stage_hunk, { desc = '[u]ndo stage hunk' })
			map('n', '<leader>gR', gitsigns.reset_buffer, { desc = '[R]eset buffer' })
			map('n', '<leader>gp', gitsigns.preview_hunk, { desc = '[p]review hunk' })
			map('n', '<leader>gb', gitsigns.blame_line, { desc = '[b]lame line' })
			map('n', '<leader>gd', gitsigns.diffthis, { desc = '[d]iff against index' })
			map('n', '<leader>gD', function()
				gitsigns.diffthis '@'
			end, { desc = '[D]iff against last commit' })
			-- Toggles
			map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
			map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
		end,
	},
}
