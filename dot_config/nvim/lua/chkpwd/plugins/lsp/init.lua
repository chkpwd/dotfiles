local list = "chkpwd.plugins.lsp."

return {
  require(list .. "mason"),
  require(list .. "nvim-lspconfig"),
}
