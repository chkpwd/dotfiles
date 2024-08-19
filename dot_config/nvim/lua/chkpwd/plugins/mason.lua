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
				"lua_ls", -- lsp
				"ruff", -- formatter
				"basedpyright", -- lsp
				"helm-ls", -- lsp
				"terraformls", -- lsp
				"ansiblels", -- lsp
				"prettier", -- formatter
				"stylua", -- formatter
				"selene", -- linter
				"yaml-language-server", -- lsp
				"yamllint", -- linter
				"yamlfmt", -- formatter
				"json-lsp", -- lsp
				"jsonlint", -- linter
				"fixjson", -- formatter
				"terraform-ls", -- lsp
				"tflint", -- linter
				"hclfmt", -- formatter
				"ansible-lint", -- linter
				--"nixpkgs-fmt", -- formatter
			},
		})
	end,
}
