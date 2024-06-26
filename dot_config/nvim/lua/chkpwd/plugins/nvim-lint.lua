return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		lint.linters_by_ft = {
			python = { "ruff" },
			ansible = { "ansible_lint" },
			actions = { "actionlint" },
			nix = { "nix" },
			bash = { "shellcheck" },
			yaml = { "yamllint" },
			json = { "jsonlint" },
			css = { "prettier" },
			html = { "prettier" },
			markdown = { "prettier" },
			lua = { "selene" },
			terraform = { "tflint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		vim.keymap.set("n", "<leader>l", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
