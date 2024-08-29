---@type LazySpec
return {
	"L3MON4D3/LuaSnip",
	config = function(plugin, opts)
		-- -- Load my custom snippets path ~/.config/nvim/snippets
		-- require("luasnip.loaders.from_vscode").load({
		-- 	paths = { vim.fn.stdpath("config") .. "/snippets" },
		-- })

		-- -- Include the default Astronvim config that calls the setup call
		-- require("astronvim.plugins.configs.luasnip")(plugin, opts)

		local ls = require("luasnip")
		local s = ls.snippet
		local t = ls.text_node
		-- local i = ls.insert_node
		local f = ls.function_node

		-- Function to get the current date
		local function get_current_date()
			return os.date("%Y-%m-%d")
		end

		-- Function to get the current user and capitalize the first letter
		local function get_current_user()
			local handle = io.popen("whoami | tr -d '\n'")
			if handle then
				local user = handle:read("*a")
				handle:close()
				if user then
					-- Capitalize the first letter of the username
					return user:sub(1, 1):upper() .. user:sub(2)
				else
					return ""
				end
			else
				return ""
			end
		end

		-- Function to get the comment string for the current file type
		local function get_comment_string()
			local commentstring = vim.bo.commentstring
			if commentstring == "" then
				commentstring = "# %s" -- Default to hash if no comment string is found
			end
			return commentstring:gsub("%%s", "")
		end

		-- Helper function to create a snippet with priority
		local function create_annotation_snippet(trigger, description)
			return s({ trig = trigger, priority = 2000 }, {
				f(function()
					return get_comment_string() .. " "
				end, {}),
				t(description .. ": ("),
				f(get_current_date, {}),
				t(") "),
				f(function()
					local user = get_current_user()
					if user ~= "" then
						return user .. " "
					else
						return ""
					end
				end, {}),
				t("=> "),
				-- i(1), -- this is the final tab stop after which you need to tab out
				--       -- of the snippet. We don't need it here, but I'm leaving it
				--       -- for posterity / documentation about how a full snippet works
			})
		end

		ls.add_snippets("all", {
			create_annotation_snippet("fixme", "FIXME"),
			create_annotation_snippet("fix", "FIX"),
			create_annotation_snippet("todo", "TODO"),
			create_annotation_snippet("hack", "HACK"),
			create_annotation_snippet("warn", "WARN"),
			create_annotation_snippet("perf", "PERF"),
			create_annotation_snippet("note", "NOTE"),
			create_annotation_snippet("test", "TEST"),
		})
	end,
}
