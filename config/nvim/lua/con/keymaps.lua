
vim.keymap.set('n', '<F9>', function()
	vim.opt.spell = not(vim.opt.spell:get())
end
 )
