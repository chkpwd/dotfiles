return {
  {
    "akinsho/toggleterm.nvim",
    opts = {
      open_mapping = [[<C-t>]],
      close_on_exit = true,
      direction = "float",
      direction = "horizontal",
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        else
          return vim.o.columns * 0.4
        end
      end,
    },
  },
}
