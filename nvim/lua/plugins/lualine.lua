return {
  "nvim-lualine/lualine.nvim",
  opts = {
    options = {
      theme = 'gruvbox',
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
