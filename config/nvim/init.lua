require("con.options")
require("con.keymaps")
require("con.plugins")
require("con.colors")
require("con.autopair")
require("con.snippet")



require("lualine").setup()
local cfg = {}
require("lsp_signature").setup(cfg)
