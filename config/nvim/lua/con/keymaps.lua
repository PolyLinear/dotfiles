
vim.keymap.set('n', '<F9>', function()
	vim.opt.spell = not(vim.opt.spell:get())
end
 )

vim.keymap.set("n", "]g", vim.diagnostic.goto_next)
vim.keymap.set("n", "[g", vim.diagnostic.goto_prev)
