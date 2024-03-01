-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode in the builtin terminal (instead of <C-\><C-n>)
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })


----------------
--❰❰ General ❱❱--
----------------

vim.g.mapleader = '\\'
vim.g.maplocalleader = '\\'

-- Enable line numbers
vim.opt.number = true

-- Sync clipboard between OS and Neovim.
vim.opt.clipboard = 'unnamedplus'

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searchinge xcept when uppercase is used in search
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- Highlight search results
vim.opt.hlsearch = true
vim.keymap.set('n', '<Leader>b', ':nohlsearch<CR>', { silent = true, desc = 'Clear search highlights' })


-------------------
--❰❰ Whitespace ❱❱--
-------------------

vim.keymap.set('n', '<Leader>p', ':set invpaste<CR>', { silent = true, desc = 'Paste mode' })

-- 1 tab = 4 spaces
vim.opt.copyindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

-- For selected filetypes, 1 tab = 2 spaces
vim.cmd('autocmd FileType html,javascript,json,lua,vim,vue,yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2')

-- highlight selected whitespace characters
vim.opt.list = true
vim.opt.listchars = {
  tab = '❱·',
  trail = '·',
  extends = '⟩',
  precedes = '⟨',
  nbsp = '␣',
}

-- Remove trailing whitespace on save
vim.cmd('autocmd BufWritePre * %s/\\s\\+$//e')

-- Auto-indent on new line
vim.opt.smartindent = true


-----------------------------
--❰❰ Buffers/Windows/Tabs ❱❱--
-----------------------------

-- CTRL-Left/Right to move between buffers
vim.keymap.set('n', '<C-Left>', ':bprev<CR>', { silent = true })
vim.keymap.set('n', '<C-Right>', ':bnext<CR>', { silent = true })

-- Alt-Left/Right/Up/Down to move between windows
vim.keymap.set('n', '<A-Up>', ':wincmd k<CR>', { silent = true, desc = 'Focus window up' })
vim.keymap.set('n', '<A-Down>', ':wincmd j<CR>', { silent = true, desc = 'Focus window down' })
vim.keymap.set('n', '<A-Left>', ':wincmd r<CR>', { silent = true, desc = 'Focus window left' })
vim.keymap.set('n', '<A-Right>', ':wincmd l<CR>', { silent = true, desc = 'Focus window right' })

-- Shift+ Left/Right to move between tabs
vim.keymap.set('n', '<S-Left>', ':tabprev<CR>', { silent = true, desc = 'Previous tab' })
vim.keymap.set('n', '<S-Right>', ':tabnext<CR>', { silent = true, desc = 'Next tab' })

-- Ctrl-Shift-Left/Right to reorder tabs
vim.keymap.set('n', '<C-S-Left>', ':tabmove -1<CR>', { silent = true, desc = 'Move tab left' })
vim.keymap.set('n', '<C-S-Right>', ':tabmove +1<CR>', { silent = true, desc = 'Move tab right' })


-- Alt +/- to increase/decrease window size
vim.keymap.set('n', '<A-=>', ':wincmd +<CR>', { silent = true, desc = 'Window size +' })
vim.keymap.set('n', '<A-->', ':wincmd -<CR>', { silent = true, desc = 'Window size -' })

-- Windows splits
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.keymap.set('n', 'vv', '<C-w>v', { silent = true, desc = 'Vertical split' })
vim.keymap.set('n', 'hh', '<C-w>s', { silent = true, desc = 'Horizontal split' })

-- Create/close buffers and tabs
vim.cmd('command! BN new')
vim.cmd('command! BD bdelete')
vim.cmd('command! TD tabclose')
vim.cmd('command! TN tabnew | vnew')

--  Switch between unsaved buffers w/o save, preserves history
vim.opt.hidden = true

-- Alt+h/j/k/l moves cursor in insert mode
vim.keymap.set('i', '<A-h>', '<Left>', { silent = true })
vim.keymap.set('i', '<A-j>', '<Down>', { silent = true })
vim.keymap.set('i', '<A-k>', '<Up>', { silent = true })
vim.keymap.set('i', '<A-l>', '<Right>', { silent = true })


----------------
--❰❰ Plugins ❱❱--
----------------

-- Install lazy.nvim
local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--branch=stable',
    lazyrepo,
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)


require('lazy').setup {
  -- Theme: Loads after first buffer is opened
  {
    'folke/tokyonight.nvim',
    event = 'BufRead',
    config = function()
      vim.cmd('colorscheme tokyonight')
    end,
  },

  -- Lumpy Space Princess
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs and related tools to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',

      -- Useful status updates for LSP.
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
    },
    config = function()
      -- Brief Aside: **What is LSP?**
      --
      -- LSP is an acronym you've probably heard, but might not understand what it is.
      --
      -- LSP stands for Language Server Protocol. It's a protocol that helps editors
      -- and language tooling communicate in a standardized fashion.
      --
      -- In general, you have a "server" which is some tool built to understand a particular
      -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc). These Language Servers
      -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
      -- processes that communicate with some "client" - in this case, Neovim!
      --
      -- LSP provides Neovim with features like:
      --  - Go to definition
      --  - Find references
      --  - Autocompletion
      --  - Symbol Search
      --  - and more!
      --
      -- Thus, Language Servers are external tools that must be installed separately from
      -- Neovim. This is where `mason` and related plugins come into play.
      --
      -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
      -- and elegantly composed help section, :help lsp-vs-treesitter

      --  This function gets run when an LSP attaches to a particular buffer.
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          -- Function to set the mode, buffer and description for an LSP mapping
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end


          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          -- Fuzzy find all the symbols in your current document.
          --  Symbols are things like variables, functions, types, etc.
          map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
          -- Fuzzy find all the symbols in your current workspace
          --  Similar to document symbols, except searches over your whole project.
          map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')

          -- The following two autocommands are used to highlight references of the
          -- word under your cursor when your cursor rests there for a little while.
          --    See `:help CursorHold` for information about when this is executed
          --
          -- When you move your cursor, the highlights will be cleared (the second autocommand).
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              callback = vim.lsp.buf.clear_references,
            })
          end
        end,
      })

      -- LSP servers and clients are able to communicate to each other what features they support.
      --  By default, Neovim doesn't support everything that is in the LSP Specification.
      --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
      --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
      --
      -- local capabilities = vim.lsp.protocol.make_client_capabilities()
      -- capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

      local servers = {
        -- clangd = {},
        pyright = {},
        -- tsserver = {},
        -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
        --

        --  Add any additional override configuration in the following tables. Available keys are:
        --  - cmd (table): Override the default command used to start the server
        --  - filetypes (table): Override the default list of associated filetypes for the server
        --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
        --  - settings (table): Override the default settings passed when initializing the server.
        --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
        -- lua_ls = {
        --   -- cmd = {...},
        --   -- filetypes { ...},
        --   -- capabilities = {},
        --   settings = {
        --     Lua = {
        --       runtime = { version = 'LuaJIT' },
        --       workspace = {
        --         checkThirdParty = false,
        --         -- Tells lua_ls where to find all the Lua files that you have loaded
        --         -- for your neovim configuration.
        --         library = {
        --           '${3rd}/luv/library',
        --           unpack(vim.api.nvim_get_runtime_file('', true)),
        --         },
        --         -- If lua_ls is really slow on your computer, you can try this instead:
        --         -- library = { vim.env.VIMRUNTIME },
        --       },
        --       completion = {
        --         callSnippet = 'Replace',
        --       },
        --       -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        --       -- diagnostics = { disable = { 'missing-fields' } },
        --     },
        --   },
        -- },
      }

      -- Ensure the servers and tools above are installed
      require('mason').setup()

      -- You can add other tools here that you want Mason to install for you
      local ensure_installed = vim.tbl_keys(servers or {})
      vim.list_extend(ensure_installed, { 'stylua' })
      require('mason-tool-installer').setup { ensure_installed = ensure_installed }

      -- TODO: capabilities
      -- require('mason-lspconfig').setup {
      --   handlers = {
      --     function(server_name)
      --       local server = servers[server_name] or {}
      --       -- Overrides for LSP config above (for example, turning off formatting for tsserver)
      --       server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
      --       require('lspconfig')[server_name].setup(server)
      --     end,
      --   },
      -- }
    end,
  },

  -- Telescope
  -- See:
  --   :help telescope
  --   :help telescope.setup()
  --   :Telescope help_tags
  {
    'nvim-telescope/telescope.nvim',
    event = 'VeryLazy',
    cmd = 'Telescope',
    dependencies = {
      'nvim-lua/plenary.nvim',
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'nvim-telescope/telescope-ui-select.nvim' },
      { 'nvim-tree/nvim-web-devicons' },
    },
    config = function()
      -- Two important keymaps to use while in telescope are:
      --  - Insert mode: <c-/>
      --  - Normal mode: ?
      require('telescope').setup {
        defaults = {
          mappings = {
            i = { ['<c-enter>'] = 'to_fuzzy_refine' },
          },
        },
        pickers = {},
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- See `:help telescope.builtin`
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[F]ind [B]uffers' })
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp tags' })
      vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
      vim.keymap.set('n', '<leader>fs', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
      vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
      vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

      -- Slightly advanced example of overriding default behavior and theme
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })

      -- Also possible to pass additional configuration options.
      --  See `:help telescope.builtin.live_grep()` for information about particular keys
      vim.keymap.set('n', '<leader>s/', function()
        builtin.live_grep {
          grep_open_files = true,
          prompt_title = 'Live Grep in Open Files',
        }
      end, { desc = '[F]ind [/] in Open Files' })

      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>sn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[F]ind [N]eovim files' })
    end,
  },

  -- Treesitter: Highlight/edit/navigate code
  -- See `:help nvim-treesitter`
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require('nvim-treesitter.configs').setup {
        ensure_installed = {
          'bash', 'fish',
          'c', 'python',
          'markdown', 'json', 'yaml',
          'html', 'css', 'javascript', 'typescript', 'vue',
          'lua', 'vim', 'vimdoc',
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
      }

      -- There are additional nvim-treesitter modules that you can use to interact
      -- with nvim-treesitter. You should go explore a few and see what interests you:
      --
      --    - Incremental selection: Included, see :help nvim-treesitter-incremental-selection-mod
      --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
      --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    end,
  },

  -- Autoformat
  {
    'stevearc/conform.nvim',
    opts = {
      notify_on_error = false,
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        javascript = { 'prettier' },
        lua = { 'stylua' },
        python = { 'ruff' },
      },
    },
  },

  -- Which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    config = function()
      require('which-key').setup()
      -- Document existing key chains
      require('which-key').register {
        ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
        ['<leader>d'] = { name = '[D]ocument', _ = 'which_key_ignore' },
        ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
        ['<leader>s'] = { name = '[F]ind', _ = 'which_key_ignore' },
        ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      }
    end,
  },
}
