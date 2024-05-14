local base = {
  red = "#ff657a",
  maroon = "#F29BA7",
  peach = "#ff9b5e",
  yellow = "#eccc81",
  green = "#a8be81",
  teal = "#9cd1bb",
  sky = "#A6C9E5",
  sapphire = "#86AACC",
  blue = "#5d81ab",
  lavender = "#66729C",
  mauve = "#b18eab",
}

local extend_base = function(value)
  return vim.tbl_extend("force", base, value)
end

return {
  {
    "catppuccin/nvim", 
    name = "catppuccin",
    priority = 1000,

    config = function()
      require("catppuccin").setup({
        background = {
          dark = "frappe",
          light = "latte",
        },
        color_overrides = {
          latte = extend_base({
            text = "#202027",
            subtext1 = "#263168",
            subtext0 = "#4c4f69",
            overlay2 = "#737994",
            overlay1 = "#838ba7",
            base = "#fcfcfa",
            mantle = "#EAEDF3",
            crust = "#DCE0E8",
            pink = "#EA7A95",
            mauve= "#986794",
            red = "#EC5E66",
            peach = "#FF8459",
            yellow = "#CAA75E",
            green = "#87A35E",
          }),
          frappe = extend_base({
            text = "#fcfcfa",
            surface2 = "#535763",
            surface1 = "#3a3d4b",
            surface0 = "#30303b",
            base = "#202027",
            mantle = "#1c1d22",
            crust = "#171719",
          }),
        },
        styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = { "italic" },
            loops = {},
            functions = {},
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        default_integrations = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            mason = true, 
            telescope = {
              enabled = true,
              -- style = "nvchad"
            },
            lsp_trouble = true,
            which_key = true,
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            indent_blankline = {
              enabled = true,
              scope_color = "lavender",
              colored_indent_levels = false,
            },
        },
      })

      vim.cmd("colorscheme catppuccin")
    end,
  },
}

