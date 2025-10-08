return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"williamboman/mason-lspconfig.nvim",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		{
			"msvechla/yaml-companion.nvim",
			branch = "kubernetes_crd_detection",
			dependencies = { "nvim-lua/plenary.nvim" },
			config = function()
				require("telescope").load_extension("yaml_schema")
			end,
		},
	},
	config = function()
		local lspconfig = require("lspconfig")
		local yaml_companion = require("yaml-companion")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				local opts = { buffer = ev.buf, silent = true }

				opts.desc = "Show LSP references"
				keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

				opts.desc = "Go to declaration"
				keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

				opts.desc = "Show LSP definitions"
				keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

				opts.desc = "Show LSP implementations"
				keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

				opts.desc = "Show LSP type definitions"
				keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

				opts.desc = "See available code actions"
				keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

				opts.desc = "Smart rename"
				keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

				opts.desc = "Show buffer diagnostics"
				keymap.set("n", "<leader>bD", "<cmd>Telescope diagnostics bufnr=0<CR>", opts)

				opts.desc = "Show line diagnostics"
				keymap.set("n", "<leader>ld", vim.diagnostic.open_float, opts)

				opts.desc = "Go to previous diagnostic"
				keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)

				opts.desc = "Go to next diagnostic"
				keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

				opts.desc = "Show documentation for what is under cursor"
				keymap.set("n", "K", vim.lsp.buf.hover, opts)

				opts.desc = "Restart LSP"
				keymap.set("n", "<leader>rs", ":LspRestart<CR>", opts)

				opts.desc = "Toggle Inlay Hints"
				keymap.set("n", "<leader>ih", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
				end, opts)
			end,
		})

		local capabilities = cmp_nvim_lsp.default_capabilities()

		local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
		end

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"basedpyright",
				"yamlls",
				"helm_ls",
				"terraformls",
				"ansiblels",
				"jsonls",
			},
			handlers = {
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["yamlls"] = function()
					lspconfig.yamlls.setup({
						settings = {
							redhat = { telemetry = { enabled = false } },
							yaml = {
								validate = true,
								format = { enable = true, singleQuote = false },
								hover = true,
								schemaStore = { enable = false, url = "" },
								keyOrdering = false,
								completion = true,
								schemas = {
									["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "docker-compose.{yml,yaml}",
									["https://json.schemastore.org/gitlab-ci"] = ".gitlab-ci.yml",
									["https://json.schemastore.org/pre-commit-config"] = ".pre-commit-config.{yml,yaml}",
									["https://json.schemastore.org/github-workflow"] = ".github/workflows/*",
									["https://json.schemastore.org/kustomization"] = "kustomization.{yml,yaml}",
									["https://json.schemastore.org/chart"] = "kubernetes/*-chart.{yml,yaml}",
									["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.30.1-standalone-strict/all.json"] = "kubernetes/*.{yml,yaml}",
								},
							},
						},
					})
					yaml_companion.setup({
						schema = {
							kubernetes = { enabled = true },
							kubernetes_crd = { enabled = true },
						},
					})
				end,
			},
		})
	end,
}
