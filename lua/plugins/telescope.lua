return {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.8',
	dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope-ui-select.nvim' },
	config = function()
		local options = {
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "ascending",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},
					width = 0.87,
					height = 0.80,
				},
				mappings = {
					n = { ["q"] = require("telescope.actions").close },
				},
			},

			extensions_list = { "themes", "terms" },
			extensions = {},
		}

		require('telescope').setup(options)
		require('telescope').load_extension('ui-select')

		local builtin = require('telescope.builtin')
		vim.keymap.set('n', '<leader>p', builtin.find_files, {})
		vim.keymap.set('n', '<leader>f', builtin.live_grep, {})
		vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
	end
}
