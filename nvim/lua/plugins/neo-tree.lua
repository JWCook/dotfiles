return {
  "nvim-neo-tree/neo-tree.nvim",
  keys = {
    { "<F6>", "<cmd>Neotree toggle<cr>", desc = "Toggle Neo-tree" },
    -- Disable some default bindings
    { "<leader>e",  false },
    { "<leader>E",  false },
    { "<leader>fe", false },
    { "<leader>fE", false },
  },
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true,
      },
      hijack_netrw_behavior = "open_current",
      use_libuv_file_watcher = true,
    },
    window = {
      position = "left",
      width = 30,
      mappings = {
        ["<F6>"] = "close_window",
      },
    },
    default_component_configs = {
      git_status = {
        symbols = {
          -- Change type
          added = "✚",
          deleted = "✖",
          modified = "✱",
          renamed = "➜",
          -- Status type
          untracked = "★",
          ignored = "◌",
          unstaged = "✗",
          staged = "✓",
          conflict = "",
        }
      },
    },
  },
}
