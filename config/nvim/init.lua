require("con.options")
require("con.keymaps")
require("con.plugins")
require("con.colors")
require("con.autopair")
require("con.snippet")

require("lualine").setup({
	options = { theme = "catppuccin", section_separators = "", component_separators = "" },
})

local cfg = {}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")
vim.api.nvim_create_autocmd("BufEnter", {
	nested = true,
	callback = function()
		if #vim.api.nvim_list_wins() == 1 and require("nvim-tree.utils").is_nvim_tree_buf() then
			vim.cmd("quit")
		end
	end,
})

require("lsp_signature").setup(cfg)
