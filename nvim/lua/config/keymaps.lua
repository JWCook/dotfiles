-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
local keymap = vim.keymap.set

-- ❰❰ Plugin Updates ❱❱
keymap('n', '<F12>', ':Lazy sync<CR>', { silent = true })
keymap('n', '<C-F12>', ':Lazy<CR>', { silent = true })

-- ❰❰ Command Abbreviations ❱❱
vim.cmd([[
ca E e
ca W w
ca WQ wq
ca Wq wq
ca WQa wqa
ca Wqa wqa
ca Qa qa
ca Q q
]])

-- ❰❰ General Mappings ❱❱
keymap('n', ';', ':', { noremap = true })
keymap('v', ';', ':', { noremap = true })
keymap('n', 'ev', ':vsplit ~/.config/nvim/init.lua<CR>')
keymap('n', 'sv', ':luafile ~/.config/nvim/init.lua<CR>')
keymap('n', 'rr', ':redraw!<CR>')
keymap('n', 'q:', '<nop>')
keymap('n', 'Q', '<nop>')

-- ❰❰ Movement Mappings ❱❱
keymap({ 'n', 'i', 'v' }, '<C-Up>', 'gk')
keymap({ 'n', 'v' }, '<C-Down>', 'gj')
keymap({ 'n', 'v' }, '<C-k>', 'gk')
keymap({ 'n', 'v' }, '<C-j>', 'gj')

-- ❰❰ Search ❱❱
keymap('n', '<leader>b', ':nohlsearch<CR>')

-- ❰❰ Telescope Mappings ❱❱
keymap('n', '<C-p>', ':Telescope find_files<CR>', { silent = true })
keymap('n', '<leader>ff', ':Telescope find_files<CR>', { silent = true })
keymap('n', '<leader>fg', ':Telescope live_grep<CR>', { silent = true })
keymap('n', '<leader>fb', ':Telescope buffers<CR>', { silent = true })
keymap('n', '<leader>fh', ':Telescope help_tags<CR>', { silent = true })
keymap('n', '<leader>fr', ':Telescope oldfiles<CR>', { silent = true })

-- ❰❰ LSP Keybindings ❱❱
keymap('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
keymap('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
keymap('n', 'gr', vim.lsp.buf.references, { desc = 'Find references' })
keymap('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
keymap('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover documentation' })
keymap('n', '<leader>ck', vim.lsp.buf.signature_help, { desc = 'Show signature help' })
keymap('n', '<leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
keymap('n', '<leader>cr', vim.lsp.buf.rename, { desc = 'Rename symbol' })
keymap('n', '<leader>cf', function() require("conform").format({ async = true }) end, { desc = 'Format code' })

-- ❰❰ Diagnostics ❱❱
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Previous diagnostic' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
keymap('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
keymap('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Diagnostics to location list' })

-- ❰❰ Trouble (Diagnostics Viewer) ❱❱
keymap('n', '<leader>tt', ':Trouble diagnostics toggle<CR>', { desc = 'Toggle trouble diagnostics' })
keymap('n', '<leader>td', ':Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer diagnostics' })
keymap('n', '<leader>ts', ':Trouble symbols toggle focus=false<CR>', { desc = 'Symbols' })

-- ❰❰ Buffers ❱❱
keymap('n', '<C-Left>', ':bprev<CR>', { silent = true })
keymap('n', '<C-Right>', ':bnext<CR>', { silent = true })
keymap('n', '<C-h>', ':bprev<CR>', { silent = true })
keymap('n', '<C-l>', ':bnext<CR>', { silent = true })

-- ❰❰ Windows ❱❱
keymap({ 'n', 'i' }, '<A-Up>', '<C-O>:wincmd k<CR>', { silent = true })
keymap({ 'n', 'i' }, '<A-Down>', '<C-O>:wincmd j<CR>', { silent = true })
keymap({ 'n', 'i' }, '<A-Left>', '<C-O>:wincmd h<CR>', { silent = true })
keymap({ 'n', 'i' }, '<A-Right>', '<C-O>:wincmd l<CR>', { silent = true })
keymap('n', '<A-k>', ':wincmd k<CR>', { silent = true })
keymap('n', '<A-j>', ':wincmd j<CR>', { silent = true })
keymap('n', '<A-h>', ':wincmd h<CR>', { silent = true })
keymap('n', '<A-l>', ':wincmd l<CR>', { silent = true })

-- ❰❰ Window Resizing ❱❱
keymap({ 'n', 'i' }, '<M-+>', '<C-O>:wincmd +<CR>', { silent = true })
keymap({ 'n', 'i' }, '<M-->', '<C-O>:wincmd -<CR>', { silent = true })
keymap({ 'n', 'i' }, '<M-=>', '<C-O>:wincmd =<CR>', { silent = true })

-- ❰❰ Window Maximize ❱❱
keymap({ 'n', 'i' }, '<C-x>', '<C-O>:resize 45 | vertical resize 100<CR>', { silent = true })

-- ❰❰ Splits ❱❱
keymap('n', 'vv', '<C-w>v', { silent = true })
keymap('n', 'hh', '<C-w>s', { silent = true })

-- ❰❰ Tabs ❱❱
keymap({ 'n', 'i' }, '<S-Left>', '<C-O>:tabp<CR>', { silent = true })
keymap({ 'n', 'i' }, '<S-Right>', '<C-O>:tabn<CR>', { silent = true })
keymap('n', '<C-S-Left>', ':tabm -1<CR>', { silent = true })
keymap('n', '<C-S-Right>', ':tabm +1<CR>', { silent = true })

-- ❰❰ Plugin-specific Mappings ❱❱
keymap({ 'n', 'i' }, '<F6>', '<ESC>:Neotree toggle<CR>', { silent = true })
keymap({ 'n', 'i' }, '<C-F6>', '<ESC>:UndotreeToggle<CR>', { silent = true })
keymap({ 'n', 'i' }, '<F7>', '<C-O>:TagbarToggle<CR>', { silent = true })
keymap({ 'n', 'i' }, '<F4>', '<C-O>za', { silent = true })

-- ❰❰ Comment Toggle ❱❱
keymap({ 'n', 'v' }, '<F3>', function() require('Comment.api').toggle.linewise.current() end, { desc = 'Toggle comment' })

-- ❰❰ Git Mappings ❱❱
keymap('n', 'gf', ':Gdiff<CR>', { silent = true })
keymap('n', 'gs', ':Git<CR>', { silent = true })
keymap('n', 'gp', ':Git pull<CR>', { silent = true })
keymap('n', 'gw', ':Gwrite<CR>', { silent = true })
keymap('n', 'gl', ':Git blame<CR>', { silent = true })
keymap('n', 'gc', ':Git commit | startinsert<CR>', { silent = true })
keymap('n', 'gu', ':Git reset --soft HEAD~1 | redraw<CR>', { silent = true })

-- ❰❰ Gitsigns ❱❱
keymap('n', '<M-\\>', ':Gitsigns toggle_signs<CR>', { silent = true })
keymap('n', ']c', ':Gitsigns next_hunk<CR>', { silent = true })
keymap('n', '[c', ':Gitsigns prev_hunk<CR>', { silent = true })
keymap('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { silent = true })
keymap('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { silent = true })
keymap('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { silent = true })

-- ❰❰ Python Execution ❱❱
keymap('n', '<F9>', ':w<CR>:exec "!python" shellescape(@%, 1)<CR>', { silent = true })

-- ❰❰ External Commands ❱❱
keymap('n', 'tt', ':!tig<CR>', { silent = true })
keymap('n', 'th', ':!tig %<CR>', { silent = true })
keymap('n', 'ls', '!ls -Alhv --group-directories-first<CR>')
