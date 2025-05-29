local on_attach = require("util.lsp").on_attach
local diagnostic_signs = require("util.lsp").diagnostic_signs

local config = function()
	local lspconfig = require("lspconfig")
	local cmp_nvim_lsp = require("cmp_nvim_lsp")
	local signs = { Error = " ", Warn = " ", Hint = "", Info = "" }

	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
	end

	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	capabilities.offsetEncoding = { "utf-16" }
	lspconfig.lua_ls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		settings = { -- custom settings for lua
			Lua = {
				-- make the language server recognize "vim" global
				diagnostics = {
					globals = { "vim" },
				},
				workspace = {
					-- make language server aware of runtime files
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})
	local luacheck = require("efmls-configs.linters.luacheck")
	local stylua = require("efmls-configs.formatters.stylua")
	---bash
	local shellcheck = require("efmls-configs.linters.shellcheck")
	local shfmt = require("efmls-configs.formatters.shfmt")

	---cpp
	local clang_tidy = require("efmls-configs.linters.clang_tidy")
	local clang_format = require("efmls-configs.formatters.clang_format")
	require("lspconfig").clangd.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		cmd = {
			"clangd",
			"--header-insertion=never",
		}
	})

	--bash
	lspconfig.bashls.setup({
		capabilities = capabilities,
		on_attach = on_attach,
		filetypes = { "sh" },
	})

	--tex
	require("lspconfig").texlab.setup({})

	--rust
	require("lspconfig").rust_analyzer.setup({
		capabilities = capabilities,
		on_attach = on_attach,
	})

	--python
 require("lspconfig").pyright.setup({})
local autopep8 = require('efmls-configs.formatters.autopep8')

	--golang
	require("lspconfig").gopls.setup({})
	local gofmt = require('efmls-configs.formatters.gofmt')

	local rustfmt = require("efmls-configs.formatters.rustfmt")

	--C#
	require'lspconfig'.csharp_ls.setup{}


	--javascript
	require'lspconfig'.ts_ls.setup{}

	--markdown
	require'lspconfig'.marksman.setup{}
	lspconfig.efm.setup({
		filetypes = {
			"lua",
			"sh",
			"cpp",
			"c",
			"rust",
			"go",
			"cs",
			"python",
			"javascript"
		},
		init_options = {
			documentFormatting = true,
			documentRangeFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			languages = {
				lua = { luacheck, stylua },
				sh = { shellcheck, shfmt },
				cpp = { clang_format, clang_tidy },
				c = { clang_format, clang_tidy },
				--	tex = { texlab },
				rust = { rustfmt },
				go = {gofmt},
				python = {autopep8},
			},
		},
	})

	-- Suppress LSP startup errors
vim.lsp.handlers["window/showMessage"] = function(err, method, result, client_id)
  if err and err.message:match("No matching language servers") then
    return -- Silently ignore this specific error
  end
  -- Default behavior if it's not the error you want to silence
  vim.lsp.handlers["window/showMessage"](err, method, result, client_id)
end
end

local lsp_fmt_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = lsp_fmt_group,
	callback = function()
		local efm = vim.lsp.get_clients({ name = "efm" })

		if vim.tbl_isempty(efm) then
			return
		end
		vim.lsp.buf.format({ name = "efm" })
	end,
})

return {
	"neovim/nvim-lspconfig",
	config = config,
	lazy = false,
	dependencies = {
		"williamboman/mason.nvim",
		"creativenull/efmls-configs-nvim",
		"hrsh7th/nvim-cmp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-nvim-lsp",
	},
}
