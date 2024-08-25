local function get_layout()
	local handle = io.popen('sleep 1 && xkbswitch -ge')
	if handle == nil then
		return ""
	end

	local output = handle:read('*a')
	handle:close()

	return output
end

local function listen_layout_change(l)
	LAYOUT = l
	if LAYOUT_WORKER_STOP ~= nil then
		return
	end

	local work = vim.uv.new_work(get_layout, listen_layout_change)
	work:queue()
end

-- Too resource-intensive...
local function layout_worker()
	vim.api.nvim_create_autocmd({"QuitPre"}, {
		callback = function() LAYOUT_WORKER_STOP = true end
	})
	listen_layout_change("")
end

local function layout()
	return LAYOUT
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
	config = function ()
		local plugin = require('lualine')
		plugin.setup {}
	end,
}
