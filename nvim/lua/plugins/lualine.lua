return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      -- theme = "catppuccin",
      -- theme = "gruvbox",
      -- theme = "everforest",
      theme = "evergarden",
      -- theme = "nord",
      -- theme = "nordic",
      -- theme = "tokyonight-night",

      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_c = { {
        'filename',
        file_status = true,
        newfile_status = false,
        path = 1,
      } }
    },
    tabline = {
      lualine_a = { {
        'buffers',
        show_filename_only = true,
        mode = 2,
      } }
    }
  },
}
