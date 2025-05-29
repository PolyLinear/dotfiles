require("con.options")
require("con.keymaps")
require("con.plugins")
require("con.colors")
require("con.snippet")

require("lualine").setup({
	options = { theme = "catppuccin", section_separators = "", component_separators = "" },
})

local cfg = {}
vim.keymap.set("n", "fr", vim.lsp.buf.rename)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.cursorline = true

vim.api.nvim_set_hl(0, 'LineNr', {fg = '#ffff9d'})
vim.api.nvim_set_hl(0, 'CursorLineNr', {fg = '#ffffff'})

--[vim.cmd[[highlight Normal ctermbg=none guibg=none]]

local set = vim.opt
set.tabstop = 4;
set.softtabstop = 4;
set.shiftwidth = 4;
require("nvim-tree").setup()

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
autopairs.add_rules {
  Rule("<", ">"):with_pair(cond.before_regex("%a+")):with_move(function(opts) return opts.char == ">" end),
}



require("lsp_signature").setup(cfg)
