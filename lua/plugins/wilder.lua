 return {
	 'gelguy/wilder.nvim',
	 config = function()
		 local wilder = require('wilder')
		 wilder.setup({
			 modes = {':'},
			 next_key = '<C-n>',
			 previous_key = '<C-p>',
			 accept_key = '<C-Space>',
		 })

		 wilder.set_option('pipeline', {
			 wilder.branch(
				 wilder.cmdline_pipeline({
					 fuzzy = 1,
					 set_pcre2_pattern = 1,
				 }),
				 wilder.python_search_pipeline({
					 pattern = 'fuzzy',
				 })
			 ),
		 })

		 wilder.set_option('renderer', wilder.popupmenu_renderer({
			 highlighter = wilder.basic_highlighter(),
			 left = {' ', wilder.popupmenu_devicons()},
			 right = {' ', wilder.popupmenu_scrollbar()},
		 }))
	 end,
 }
