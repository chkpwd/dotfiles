local list = "chkpwd.plugins.lsp."

return {
  require(list .. "nvim-lspconfig"),
  require(list .. "mason"),
}
