local options = {
	mouse = "",
	expandtab = true,
	smartindent = true,
	shiftwidth = 4,
	tabstop = 4,
	number = true,
}

for k, v in pairs(options) do
	vim.opt[k] = v
end

-- use noexpandtab for Golang
vim.api.nvim_create_augroup("vimrc", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "go,lua" },
	group = "vimrc",
	command = ":set noexpandtab",
})

-- for .proto
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "proto,lua" },
	group = "vimrc",
	command = ":set sw=2",
})
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = { "proto,lua" },
	group = "vimrc",
	command = ":set ts=2",
})

-- restore cursor position
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})
