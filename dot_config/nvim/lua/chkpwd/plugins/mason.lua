return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"lua_ls",
				"ruff",
				"helm_ls",
				"terraformls",
				"ansiblels",
				"prettier",
				"stylua",
				"yaml-language-server",
				"yamllint",
				"yamlfmt",
				"json-lsp",
				"jsonlint",
				"fixjson",
				"terraform-ls",
				"tflint",
				"hclfmt",
				"helm-ls",
				"ansible-lint",
				"nixpkgs-fmt",
			},
		})
	end,
}
