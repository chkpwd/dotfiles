return {
	"stevearc/oil.nvim",
	cmd = "Oil",
	init = function() -- start oil on startup lazily if necessary
		if vim.fn.argc() == 1 then
			local arg = vim.fn.argv(0)
			---@cast arg string
			local stat = (vim.uv or vim.loop).fs_stat(arg)
			local adapter = string.match(arg, "^([%l-]*)://")
			if (stat and stat.type == "directory") or adapter == "oil-ssh" then
				require("oil")
			end
		else
			local augroup = vim.api.nvim_create_augroup("oil_start", { clear = true })
			vim.api.nvim_create_autocmd("BufNew", {
				desc = "start oil when editing a directory",
				group = augroup,
				callback = function()
					if package.loaded["oil"] then
						vim.api.nvim_del_augroup_by_id(augroup)
					elseif vim.fn.isdirectory(vim.fn.expand("<afile>")) == 1 then
						require("oil")
						vim.api.nvim_del_augroup_by_id(augroup)
					end
				end,
			})
		end

		vim.keymap.set("n", "-", "<Cmd>Oil<CR>", { desc = "Open parent directory" })
		vim.keymap.set("n", "<space>-", function()
			require("oil").toggle_float()
		end, { desc = "Open oil window" })
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
	opts = {
		columns = { "icon" },
		keymaps = {
			["<C-h>"] = false,
			["<M-h>"] = "actions.select_split",
		},
		view_options = {
			show_hidden = true,
		},
	},
}
