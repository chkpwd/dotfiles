local opt = vim.opt

-- lsp configs
local function yaml_ft(path, bufnr)
	-- get content of buffer as string
	local content = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
	if type(content) == "table" then
		content = table.concat(content, "\n")
	end

	-- check if file is in roles, tasks, or handlers folder
	local path_regex = vim.regex("(tasks\\|roles\\|handlers)/")
	if path_regex and path_regex:match_str(path) then
		return "yaml.ansible"
	end
	-- check for known ansible playbook text and if found, return yaml.ansible
	local regex = vim.regex("hosts:\\|tasks:")
	if regex and regex:match_str(content) then
		return "yaml.ansible"
	end

	-- return yaml if nothing else
	return "yaml"
end

vim.filetype.add({
	extension = {
		yml = yaml_ft,
		yaml = yaml_ft,
	},
})

vim.g.netrw_liststyle = 3

opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 2 -- 2 spaces for tabs (prettier default)
opt.shiftwidth = 2 -- 2 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

opt.wrap = false

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

opt.cursorline = true

-- turn on termguicolors
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- turn off swapfile
opt.swapfile = false
