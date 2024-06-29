return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				css = { "prettier" },
				html = { "prettier" },
				markdown = { "prettier" },
				json = { "fixjson" },
				yaml = { "yamlfmt" },
				lua = { "stylua" },
				python = { "ruff" },
				nix = { "alejandra" },
				terraform = { "terraform_fmt" },
				ansible = { "ansible" },
				packer = { "packer_fmt" },
				bash = { "shfmt", "shellcheck" },
			},
			format_on_save = {
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			},
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
