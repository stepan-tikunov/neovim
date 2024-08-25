function SetColorscheme(color)
	color = color or "rose-pine"

	vim.cmd.colorscheme(color)
end

return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
	{
		"arzg/vim-colors-xcode",
		name = "xcode-colors",
		config = function()
			SetColorscheme("xcode")
		end,
	}
}

