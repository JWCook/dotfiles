-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- TODO:
-- To bind:
-- Obsidian smart_action
-- Obsidian rename -> F2
-- Obsidian quick_switch
local command = vim.api.nvim_create_user_command
local keymap = vim.keymap.set

-- ❰❰ Plugin Updates ❱❱
keymap('n', '<F12>', ':Lazy sync<CR>', { silent = true })
keymap('n', '<F36>', ':Lazy<CR>', { silent = true })

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
keymap('n', 'sv', ':Lazy reload<CR>')
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
keymap('n', '<F5>',  ':Telescope find_files<CR>', { silent = true })
keymap('n', '<F29>', ':Telescope live_grep<CR>', { silent = true })  -- C-F5
keymap('n', '<F17>', ':Telescope buffers<CR>', { silent = true })  -- S-F5
keymap('n', '<F53>', ':Telescope oldfiles<CR>', { silent = true })  -- A-F5
keymap('n', '<F25>', ':Telescope help_tags<CR>', { silent = true })  -- C-F1

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
keymap('n', '[d', function() vim.diagnostic.jump({ count = -1 }) end, { desc = 'Previous diagnostic' })
keymap('n', ']d', function() vim.diagnostic.jump({ count = 1 }) end, { desc = 'Next diagnostic' })
keymap('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Show line diagnostics' })
keymap('n', '<leader>cq', vim.diagnostic.setloclist, { desc = 'Diagnostics to location list' })

-- ❰❰ Trouble (Diagnostics Viewer) ❱❱
keymap('n', '<F8>', ':Trouble diagnostics toggle<CR>', { desc = 'Toggle trouble diagnostics' })
keymap('n', '<F20>', ':Trouble diagnostics toggle filter.buf=0<CR>', { desc = 'Buffer diagnostics' })
keymap('n', '<F32>', ':Trouble symbols toggle focus=false<CR>', { desc = 'Symbols' })

-- ❰❰ Buffers ❱❱
keymap('n', '<C-Left>', ':bprev<CR>', { silent = true })
keymap('n', '<C-Right>', ':bnext<CR>', { silent = true })
keymap('n', '<C-h>', ':bprev<CR>', { silent = true })
keymap('n', '<C-l>', ':bnext<CR>', { silent = true })
command("BD", function() Snacks.bufdelete() end, {})
command("BN", ":new", {})

-- ❰❰ Windows ❱❱
keymap('n', '<A-Up>',    ':wincmd k<CR>', { silent = true })
keymap('n', '<A-Down>',  ':wincmd j<CR>', { silent = true })
keymap('n', '<A-Left>',  ':wincmd h<CR>', { silent = true })
keymap('n', '<A-Right>', ':wincmd l<CR>', { silent = true })
keymap('n', '<A-k>',     ':wincmd k<CR>', { silent = true })
keymap('n', '<A-j>',     ':wincmd j<CR>', { silent = true })
keymap('n', '<A-h>',     ':wincmd h<CR>', { silent = true })
keymap('n', '<A-l>',     ':wincmd l<CR>', { silent = true })

-- ❰❰ Window Resizing ❱❱
keymap({ 'n', 'i' }, '<M-+>', '<C-O>:wincmd +<CR>', { silent = true })
keymap({ 'n', 'i' }, '<M-->', '<C-O>:wincmd -<CR>', { silent = true })
keymap({ 'n', 'i' }, '<M-=>', '<C-O>:wincmd =<CR>', { silent = true })
keymap({ 'n', 'i' }, '<C-x>', '<C-O>:resize 45 | vertical resize 100<CR>', { silent = true })

-- ❰❰ Window Splits ❱❱
keymap('n', 'vv', '<C-w>v', { silent = true })
keymap('n', 'hh', '<C-w>s', { silent = true })

-- ❰❰ Tabs ❱❱
command("TD", "tabclose", {})
command("TN", "tabnew | vsp", {})
keymap({ 'n', 'i' }, '<S-Left>', '<C-O>:tabp<CR>', { silent = true })
keymap({ 'n', 'i' }, '<S-Right>', '<C-O>:tabn<CR>', { silent = true })
keymap('n', '<C-S-Left>', ':tabm -1<CR>', { silent = true })
keymap('n', '<C-S-Right>', ':tabm +1<CR>', { silent = true })

-- ❰❰ Other Plugin-specific Mappings ❱❱
keymap('n', '<F4>', '>za', { silent = true })
keymap('n', '<F6>', ':Neotree toggle<CR>', { silent = true })
keymap('n', '<F30>', ':UndotreeToggle<CR>', { silent = true })
keymap('n', '<F7>', ':TagbarToggle<CR>', { silent = true })
keymap('n', '<F10>', ':YankyRingHistory<CR>', { silent = true })

-- ❰❰ Comment Toggle ❱❱
keymap('n', '<F3>', 'gcc', { remap = true, desc = 'Toggle line comment' })
keymap('v', '<F3>', 'gc', { remap = true, desc = 'Toggle comment on selection' })
keymap('n', '<C-F3>', 'gbc', { remap = true, desc = 'Toggle block comment' })
keymap('v', '<C-F3>', 'gb', { remap = true, desc = 'Toggle block comment on selection' })

-- ❰❰ Gitsigns ❱❱
keymap('n', '<M-\\>', ':Gitsigns toggle_signs<CR>', { silent = true })
keymap('n', ']c', ':Gitsigns next_hunk<CR>', { silent = true })
keymap('n', '[c', ':Gitsigns prev_hunk<CR>', { silent = true })
keymap('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', { silent = true })
keymap('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', { silent = true })
keymap('n', '<leader>hp', ':Gitsigns preview_hunk<CR>', { silent = true })

-- ❰❰ External Commands ❱❱
keymap('n', 'py', ':w<CR>:exec "!python3" shellescape(@%, 1)<CR>', { silent = true })
keymap('n', 'tt', ':!tig<CR>', { silent = true })
keymap('n', 'th', ':!tig %<CR>', { silent = true })
keymap('n', 'll', '!ll<CR>')
