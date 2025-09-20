-- Additional plugins not included in LazyVim

return {
  -- Disable noice plugin (until it's more stable)
  {
    "folke/noice.nvim",
    enabled = false,
  },

  -- Obsidian integration
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*", -- use latest release instead of latest commit
    ft = "markdown",
    config = function()
      require("obsidian").setup({
        legacy_commands = false,
        workspaces = {
          {
            name = "personal",
            -- path = "~/Documents/ObsidianVault",
            path = "~/Nextcloud/Notes",
          },
        },
        callbacks = {
          enter_note = function(_, note)
            vim.keymap.set("n", "<Tab>", function()
                require("obsidian.api").nav_link("next")
            end, {
                buffer = note.bufnr,
                desc = "Go to next link",
            })
            vim.keymap.set("n", "<S-Tab>", function()
                require("obsidian.api").nav_link("prev")
            end, {
                buffer = note.bufnr,
                desc = "Go to previous link",
            })
          end,
      },
    })
    end,
  },

  -- Git integration + syntax highlighting
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "GBrowse", "Gdiff", "Gwrite" },
    keys = {
      { "gs", "<cmd>Git<cr>", desc = "Git status" },
      { "gf", "<cmd>Gdiff<cr>", desc = "Git diff" },
      { "gp", "<cmd>Git pull<cr>", desc = "Git pull" },
      { "gw", "<cmd>Gwrite<cr>", desc = "Git write" },
      { "gl", "<cmd>Git blame<cr>", desc = "Git blame" },
      { "gc", "<cmd>Git commit | startinsert<cr>", desc = "Git commit" },
      { "gu", "<cmd>Git reset --soft HEAD~1 | redraw<cr>", desc = "Git undo last commit" },
    },
  },
  {
    "tpope/vim-git",
    ft = { "git", "gitcommit", "gitconfig", "gitrebase", "gitsendemail" },
  },

  -- Undo tree
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle",
    keys = {
      { "<C-F6>", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undo Tree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2
      vim.g.undotree_SetFocusWhenToggle = 1
    end,
  },

  -- Code outline with tags
  {
    "majutsushi/tagbar",
    cmd = "TagbarToggle",
    keys = {
      { "<F7>", "<cmd>TagbarToggle<cr>", desc = "Toggle Tagbar" },
    },
    config = function()
      vim.g.tagbar_width = 30
      vim.g.tagbar_autoclose = 1
      vim.g.tagbar_autofocus = 1
      vim.g.tagbar_sort = 0
    end,
  },

  -- Yank history
  {
    "gbprod/yanky.nvim",
    opts = {
      highlight = { timer = 150 },
      ring = { history_length = 100 },
      preserve_cursor_position = { enabled = true },
    },
    keys = {
      { "y", "<Plug>(YankyYank)", mode = {"n", "x"}, desc = "Yank text" },
      { "p", "<Plug>(YankyPutAfter)", mode = {"n", "x"}, desc = "Put yanked text after cursor" },
      { "P", "<Plug>(YankyPutBefore)", mode = {"n", "x"}, desc = "Put yanked text before cursor" },
      { "<c-p>", "<Plug>(YankyPreviousEntry)", desc = "Select previous entry through yank history" },
      { "<c-n>", "<Plug>(YankyNextEntry)", desc = "Select next entry through yank history" },
      { "]p", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[p", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { "]P", "<Plug>(YankyPutIndentAfterLinewise)", desc = "Put indented after cursor (linewise)" },
      { "[P", "<Plug>(YankyPutIndentBeforeLinewise)", desc = "Put indented before cursor (linewise)" },
      { ">p", "<Plug>(YankyPutIndentAfterShiftRight)", desc = "Put and indent right" },
      { "<p", "<Plug>(YankyPutIndentAfterShiftLeft)", desc = "Put and indent left" },
      { ">P", "<Plug>(YankyPutIndentBeforeShiftRight)", desc = "Put before and indent right" },
      { "<P", "<Plug>(YankyPutIndentBeforeShiftLeft)", desc = "Put before and indent left" },
      { "=p", "<Plug>(YankyPutAfterFilter)", desc = "Put after applying a filter" },
      { "=P", "<Plug>(YankyPutBeforeFilter)", desc = "Put before applying a filter" },
    },
  },

  -- Buffer management
  {
    "famiu/bufdelete.nvim",
    lazy = false
  },

  -- Comment toggle
  {
    "numToStr/Comment.nvim",
    opts = {
      mappings = false,
    },
  },

  -- Whitespace highlight/trim
  {
    "nvim-mini/mini.trailspace",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require('mini.trailspace').setup()
    end,
    keys = {
      { "wt", function() require('mini.trailspace').highlight() end, desc = "Toggle whitespace highlighting" },
    },
  },

  -- Surrounding pair operators
  {
    "kylechui/nvim-surround",
    version = "*", -- Omit to use `main` branch
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({})
    end
  },

  -- Terminal integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<F9>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { "<F9>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", mode = "t" },
      { "<F9>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal", mode = "i" },
    },
    opts = {
      close_on_exit = true,
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
  },

  -- Tmux navigation
  {
    "christoomey/vim-tmux-navigator",
    keys = {
      { "<c-h>",  "<cmd>TmuxNavigateLeft<cr>",     desc = "Tmux navigate left" },
      { "<c-j>",  "<cmd>TmuxNavigateDown<cr>",     desc = "Tmux navigate down" },
      { "<c-k>",  "<cmd>TmuxNavigateUp<cr>",       desc = "Tmux navigate up" },
      { "<c-l>",  "<cmd>TmuxNavigateRight<cr>",    desc = "Tmux navigate right" },
      { "<c-\\>", "<cmd>TmuxNavigatePrevious<cr>", desc = "Tmux navigate previous" },
    },
  },

}
