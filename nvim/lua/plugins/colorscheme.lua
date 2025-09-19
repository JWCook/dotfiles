-- Colorscheme configuration

return {
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("gruvbox").setup({
        terminal_colors = true,
        dim_inactive = false,
        transparent_mode = false,
      })
    end,
  },

  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
  },

  {
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
  },

  {
    'everviolet/nvim',
    name = 'evergarden',
    lazy = false,
    priority = 1000,
    opts = {
      theme = {
        variant = 'winter', -- winter|fall|spring|summer
        accent = 'green',
      },
      editor = {
        transparent_background = false,
        sign = { color = 'none' },
        float = {
            color = 'mantle',
            solid_border = false,
      },
      completion = {
            color = 'surface0',
        },
      },
    },
  },

  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "catppuccin",
      -- colorscheme = "everforest",
      colorscheme = "evergarden",
      -- colorscheme = "gruvbox",
      -- colorscheme = "nord",
      -- colorscheme = "nordic",
      -- colorscheme = "tokyonight-night",
    },
  },
}
