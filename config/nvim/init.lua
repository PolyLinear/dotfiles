require("con.options")
require("con.keymaps")
require("con.plugins")
require("con.colors")
require("con.snippet")

require("lualine").setup({
	options = { theme = "catppuccin", section_separators = "", component_separators = "" },
})

local cfg = {}

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>")

local autopairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")
local cond = require("nvim-autopairs.conds")
autopairs.add_rules {
  Rule("<", ">"):with_pair(cond.before_regex("%a+")):with_move(function(opts) return opts.char == ">" end),
}

require("lsp_signature").setup(cfg)
