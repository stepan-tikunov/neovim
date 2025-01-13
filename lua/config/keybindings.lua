vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set({"n", "v", "i"}, "<D-e>", vim.cmd.Explore)

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<D-v>", [["_dP]])

vim.keymap.set({"n", "v"}, "<D-c>", [["+y]])
vim.keymap.set("n", "<D-C>", [["+Y]])

vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

vim.keymap.set("n", "<D-o>", function()
	vim.ui.input({ prompt = "Open directory: ", completion = "dir" },
		function(dir)
			if dir == nil then
				return
			end

			local attr = vim.loop.fs_stat(vim.fn.expand(dir))
			local dir_exists = attr and attr.type == 'directory'

			if not dir_exists then
				print("Directory " .. dir .. " not found")
				return
			end

			vim.cmd("cd " .. dir)
			vim.cmd("Explore " .. dir)
		end
	)
end)

vim.keymap.set("n", "<leader>oc", function()
	local dir = "~/.config/nvim"
	vim.cmd("cd " .. dir)
	vim.cmd("Explore " .. dir)
end)

vim.keymap.set("v", "<D-/>", "gc")
