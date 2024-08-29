return { -- override nvim-cmp plugin
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-emoji",
		"saadparwaiz1/cmp_luasnip",
		"zbirenbaum/copilot.lua",
		"L3MON4D3/LuaSnip",
		"onsails/lspkind.nvim",
	},
	opts = function(_, _opts)
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local copilot_suggestion = require("copilot.suggestion")

		local function is_word_before_cursor(words)
			local line = vim.api.nvim_get_current_line()
			local col = vim.api.nvim_win_get_cursor(0)[2]
			local before_cursor = line:sub(1, col):lower()

			for _, word in ipairs(words) do
				if before_cursor:match(word .. "%s*$") then
					return true
				end
			end
			return false
		end

		local comment_annotation_snippet = {
			"fixme",
			"fix",
			"todo",
			"hack",
			"warn",
			"perf",
			"note",
			"test",
		}

		local copilot_timer = nil
		local function pause_copilot(duration)
			-- Cancel previous timer if it exists
			if copilot_timer then
				vim.fn.timer_stop(copilot_timer)
			end

			-- Disable Copilot suggestions
			copilot_suggestion.toggle_auto_trigger()

			-- Schedule re-enabling after the specified duration
			copilot_timer = vim.defer_fn(function()
				copilot_suggestion.toggle_auto_trigger()
				copilot_timer = nil
			end, duration * 1000) -- Convert seconds to milliseconds
		end

		local cmp_timer = nil
		local function pause_cmp(duration)
			-- Cancel previous timer if it exists
			if cmp_timer then
				vim.fn.timer_stop(cmp_timer)
			end

			require("cmp").setup.buffer({ enabled = false })

			-- Schedule re-enabling after the specified duration
			cmp_timer = vim.defer_fn(function()
				require("cmp").setup.buffer({ enabled = true })
				cmp_timer = nil
			end, duration * 1000) -- Convert seconds to milliseconds
		end

		return {
			mapping = cmp.mapping.preset.insert({
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-u>"] = cmp.mapping.scroll_docs(-4),
				["<C-d>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<Tab>"] = cmp.mapping(function(fallback)
					if luasnip.expandable() and is_word_before_cursor(comment_annotation_snippet) then
						luasnip.expand()
					elseif luasnip.jumpable(1) then
						luasnip.jump(1)
					elseif copilot_suggestion.is_visible() then
						copilot_suggestion.accept()
					else
						fallback() -- tabout plugin / default tab behavior
					end
				end, { "i", "s" }),
				["<S-Tab>"] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					elseif cmp.visible() then
						cmp.select_prev_item()
					else
						fallback() -- tabout plugin / default tab behavior
					end
				end, { "i", "s" }),
				["<BS>"] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.abort()
						-- after hitting backspace to dismiss a cmp suggestion, wait <n>
						-- seconds before re-enabling so we can use the tabout fallback
						-- to get out of quotes or parens, etc.
						pause_cmp(5)
					elseif copilot_suggestion.is_visible() then
						-- after hitting backspace to dismiss a copilot suggestion, wait <n>
						-- seconds before re-enabling so we can use the tabout fallback to
						-- get out of quotes or parens, etc.
						pause_copilot(5)
						copilot_suggestion.dismiss()
					else
						fallback()
					end
				end, { "i" }),
			}),
			sources = cmp.config.sources({
				{ name = "luasnip", priority = 1000 },
				{ name = "copilot", priority = 900 },
				{ name = "nvim_lsp", priority = 800 },
				{ name = "emoji", priority = 700 },
				{ name = "buffer", priority = 500 },
				{ name = "path", priority = 250 },
			}),
			formatting = {
				format = function(entry, vim_item)
					vim_item.kind = require("lspkind").presets.default[vim_item.kind] .. " " .. vim_item.kind
					vim_item.menu = ({
						luasnip = "[Snippet]",
						copilot = "[Copilot]",
						nvim_lsp = "[LSP]",
						emoji = "[Emoji]",
						buffer = "[Buffer]",
						path = "[Path]",
					})[entry.source.name]
					return vim_item
				end,
			},
			completion = {
				completeopt = "menu,menuone,noinsert", -- ,noselect is another option
			},

			-- Hide copilot suggestions if the cmp menu is open or the specific
			-- comment annotation keywords are present: fixme, fix, todo, hack, warn,
			-- perf, note, test
			cmp.event:on("menu_opened", function()
				if is_word_before_cursor(comment_annotation_snippet) then
					print("fixme is present")
					vim.b.copilot_suggestion_hidden = true
				else
					print("no special word")
					vim.b.copilot_suggestion_hidden = false
				end
			end),

			cmp.event:on("menu_closed", function()
				vim.b.copilot_suggestion_hidden = false
			end),
		}
	end,
}
