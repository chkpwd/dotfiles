local list = "chkpwd.plugins.ide."

return {
  require(list .. "nvim-tree"),
  require(list .. "auto-session"),
  require(list .. "lualine"),
  require(list .. "nvim-tree"),
  require(list .. "telescope"),
  require(list .. "toggleterm"),
  require(list .. "catppuccin"),
  require(list .. "vim-maximizer"),
  require(list .. "vim-tmux-navigator"),
  require(list .. "which-key"),
}
