local list = "chkpwd.plugins.dev."

return {
  require(list .. "comment"),
  require(list .. "conform"),
  require(list .. "indent-blankline"),
  require(list .. "nvim-autopairs"),
  require(list .. "nvim-cmp"),
  require(list .. "nvim-lint"),
  require(list .. "nvim-treesitter"),
  require(list .. "trouble"),
}
