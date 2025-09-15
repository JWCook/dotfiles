-- ❰❰ Python ❱❱
local venv_dir = vim.env.HOME .. '/.virtualenvs/nvim'
vim.g.python_host_prog = venv_dir .. '/bin/python3'
vim.g.python3_host_prog = venv_dir .. '/bin/python3'

-- ❰❰ Plugin Management ❱❱
-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugin specifications
require("lazy").setup({
  -- UI
  {
    "vim-airline/vim-airline",
    dependencies = { "vim-airline/vim-airline-themes" },
    config = function()
      vim.g.airline_theme = 'deep_space'
      vim.g.airline_powerline_fonts = 1
      vim.g['airline#extensions#tabline#enabled'] = 1
      vim.g['airline#extensions#tabline#fnamemod'] = ':t'
    end,
  },
  { "nathanaelkane/vim-indent-guides" },
  { "roman/golden-ratio" },
  { "farmergreg/vim-lastplace" },

  -- Git
  { "tpope/vim-fugitive" },
  { "tpope/vim-git" },
  { "tpope/vim-rhubarb" },
  { "shumphrey/fugitive-gitlab.vim" },
  { "airblade/vim-gitgutter" },

  -- Fuzzy finder
  {
    "junegunn/fzf",
    build = function()
      vim.fn["fzf#install"]()
    end
  },

  -- Search
  {
    "Shougo/denite.nvim",
    build = ":UpdateRemotePlugins",
  },

  -- Syntax
  { "chrisbra/csv.vim" },
  { "dag/vim-fish" },
  { "pangloss/vim-javascript" },
  { "Glench/Vim-Jinja2-Syntax" },
  { "NoahTheDuke/vim-just" },
  { "godlygeek/tabular" },
  { "cespare/vim-toml" },
  { "WolfgangMehner/bash-support" },
  {
    "frazrepo/vim-rainbow",
    config = function()
      vim.g.rainbow_active = 1
    end,
  },

  -- Markdown/Docs
  { "tpope/vim-markdown" },
  { "jtratner/vim-flavored-markdown" },

  -- Other Utilities (Commands)
  { "qpkorr/vim-bufkill" },
  { "tomtom/tcomment_vim" },
  { "ntpeters/vim-better-whitespace" },

  -- Other Utilities (UI)
  { "vim-scripts/Gundo" },
  { "preservim/nerdtree" },
  { "Xuyuanp/nerdtree-git-plugin" },
  { "tiagofumo/vim-nerdtree-syntax-highlight" },
  { "majutsushi/tagbar" },
  { "Shougo/neoyank.vim" },

  -- Syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "lua", "vim", "vimdoc", "python", "bash", "javascript",
          "html", "css", "json", "yaml", "toml", "markdown"
        },
        auto_install = true,
        highlight = {
          enable = true,
          disable = function(lang, buf)
            local max_filesize = 100 * 1024 -- 100 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
        },
        indent = { enable = true },
      })
    end,
  },

  -- Color schemes
  { "ayu-theme/ayu-vim" },
  { "tyrannicaltoucan/vim-deep-space" },
  { "sainnhe/everforest" },
  { "morhetz/gruvbox" },
  { "nanotech/jellybeans.vim" },
  { "EdenEast/nightfox.nvim" },
  { "arcticicestudio/nord-vim" },
  { "drewtempelmeyer/palenight.vim" },
  { "lifepillar/vim-solarized8" },
  { "chlorm/vim-monokai-truecolor" },
  { "jacoborus/tender.vim" },
  { "rakr/vim-two-firewatch" },
  { "Donearm/Ubaryd" },

  -- Must be loaded last
  { "ryanoasis/vim-devicons" },
})

-- ❰❰ Terminal Codes ❱❱
-- Terminal key mappings for better compatibility
vim.cmd([[
set <F13>=\e[1;2P
set <F14>=\e[1;2Q
set <F15>=\e[1;2R
set <F16>=\e[1;2S
set <F25>=\e[1;5P
set <F26>=\e[1;5Q
set <F27>=\e[1;5R
set <F28>=\e[1;5S
set <F37>=\e[1;6P
]])

-- ❰❰ Plugin Settings ❱❱
local ignore_files = {
  '__pycache__', '~$', '.egg-info$', '^.cache$', '^.git$', '^.idea',
  '^.sonar$', '^.tox$', '_build$', '^docs/_build', '^dist$', 'htmlcov$',
  '^tmp$', '^.coverage$', '.a$', '.class$', '.idea$', '.o$', '.obj$',
  '.pyc$', '.sw\\a$', '.so$'
}

-- Bash Support
vim.g.BASH_InsertFileHeader = 'yes'

-- FZF
vim.g.fzf_preview_command = 'bat --color=always --plain {-1}'
vim.g.fzf_layout = { window = { width = 0.9, height = 0.6 } }

-- NERD Tree
vim.g.NERDTreeIgnore = ignore_files
vim.g.NERDTreeShowHidden = 1
vim.g.NERDTreeWinSize = 28

-- Gundo
vim.g.gundo_width = 30
vim.g.gundo_close_on_revert = 1

-- Tagbar
vim.g.tagbar_width = 20
vim.g.tagbar_compact = 1
vim.g.tagbar_zoomwidth = 0
vim.g.tagbar_sort = 0

-- GitGutter
vim.g.gitgutter_realtime = 0
vim.g.gitgutter_eager = 0
vim.g.gitgutter_sign_added = '➕'
vim.g.gitgutter_sign_removed = '➖'
vim.g.gitgutter_sign_modified_removed = '≃'

-- Indent guides
vim.g.indent_guides_enable_on_vim_startup = 1
vim.g.indent_guides_guide_size = 1
vim.g.indent_guides_auto_colors = 0

-- Pytest
vim.g.pytest_test_dir = 'test'

-- ❰❰ General Settings ❱❱
vim.opt.viminfo = "'100,n" .. vim.env.HOME .. "/.vim/viminfo"
vim.opt.mouse = ""
vim.opt.backup = false
vim.opt.sessionoptions:remove({ "options", "folds" })
vim.opt.timeoutlen = 200
vim.opt.ttimeoutlen = 50
vim.opt.wildignore = "*/__pycache__/*,*/.tox/*,*.o,*.a,*~,*.class,*.gif,*.jpg,*.la,*.mo,*.obj,*.png,*.pyc,*.so,*.sw*,*.xpm"
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt.undodir = vim.env.HOME .. "/.vim/undo"
vim.opt.undofile = true
vim.opt.laststatus = 2

-- ❰❰ Colors and Fonts ❱❱
vim.opt.termguicolors = true
vim.cmd.colorscheme("gruvbox")
vim.opt.background = "dark"

-- Color columns
vim.opt.colorcolumn = "80,100,120"

-- ❰❰ Whitespace ❱❱
vim.opt.copyindent = true
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.list = true
vim.opt.listchars = { tab = "❱·", nbsp = "¤" }
vim.opt.wrap = true
vim.opt.showbreak = "❱❱❱❱"
vim.opt.whichwrap:append("<,>,h,l")

-- ❰❰ Search ❱❱
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- ❰❰ User Interface ❱❱
vim.opt.number = true
vim.opt.fillchars:append("vert:▚")
vim.opt.lazyredraw = true
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.showmatch = true
vim.opt.mat = 2

-- ❰❰ Buffers/Windows/Tabs ❱❱
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.hidden = true

-- ❰❰ NetRW ❱❱
vim.g.netrw_keepdir = 0

-- ❰❰ Key Mappings ❱❱
local keymap = vim.keymap.set

-- Plugin updates
keymap('n', '<F12>', ':Lazy sync<CR>', { silent = true })
keymap('n', '<F24>', ':Lazy<CR>', { silent = true })

-- Command abbreviations
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

-- General mappings
keymap('n', ';', ':', { noremap = true })
keymap('v', ';', ':', { noremap = true })
keymap('n', 'ev', ':vsplit $MYVIMRC<CR>')
keymap('n', 'sv', ':source $MYVIMRC<CR>')
keymap('n', 'rr', ':redraw!<CR>')
keymap('n', 'q:', '<nop>')
keymap('n', 'Q', '<nop>')

-- Movement mappings
keymap({ 'n', 'i', 'v' }, '<C-Up>', 'gk')
keymap({ 'n', 'v' }, '<C-Down>', 'gj')
keymap({ 'n', 'v' }, '<C-k>', 'gk')
keymap({ 'n', 'v' }, '<C-j>', 'gj')

-- Search
keymap('n', '<leader>b', ':nohlsearch<CR>')

-- Buffers
keymap('n', '<C-Left>', ':bprev<CR>', { silent = true })
keymap('n', '<C-Right>', ':bnext<CR>', { silent = true })
keymap('n', '<C-h>', ':bprev<CR>', { silent = true })
keymap('n', '<C-l>', ':bnext<CR>', { silent = true })

-- Windows
keymap({ 'n', 'i' }, '<A-Up>', '<C-O>:wincmd k<CR>', { silent = true })
keymap({ 'n', 'i' }, '<A-Down>', '<C-O>:wincmd j<CR>', { silent = true })
keymap({ 'n', 'i' }, '<A-Left>', '<C-O>:wincmd h<CR>', { silent = true })
keymap({ 'n', 'i' }, '<A-Right>', '<C-O>:wincmd l<CR>', { silent = true })
keymap('n', '<A-k>', ':wincmd k<CR>', { silent = true })
keymap('n', '<A-j>', ':wincmd j<CR>', { silent = true })
keymap('n', '<A-h>', ':wincmd h<CR>', { silent = true })
keymap('n', '<A-l>', ':wincmd l<CR>', { silent = true })

-- Window resizing
keymap({ 'n', 'i' }, '<M-+>', '<C-O>:wincmd +<CR>', { silent = true })
keymap({ 'n', 'i' }, '<M-->', '<C-O>:wincmd -<CR>', { silent = true })
keymap({ 'n', 'i' }, '<M-=>', '<C-O>:wincmd =<CR>', { silent = true })

-- Window maximize
keymap({ 'n', 'i' }, '<C-x>', '<C-O>:resize 45 | vertical resize 100<CR>', { silent = true })

-- Splits
keymap('n', 'vv', '<C-w>v', { silent = true })
keymap('n', 'hh', '<C-w>s', { silent = true })

-- Tabs
keymap({ 'n', 'i' }, '<S-Left>', '<C-O>:tabp<CR>', { silent = true })
keymap({ 'n', 'i' }, '<S-Right>', '<C-O>:tabn<CR>', { silent = true })
keymap('n', '<C-S-Left>', ':tabm -1<CR>', { silent = true })
keymap('n', '<C-S-Right>', ':tabm +1<CR>', { silent = true })

-- Plugin-specific mappings
keymap('n', '<F3>', ':TComment<CR>', { silent = true })
keymap('i', '<F3>', '<C-O>:TComment<CR>', { silent = true })
keymap('v', '<F3>', ':TCommentBlock<CR>', { silent = true })
keymap('v', '<F4>', ':VSResize<CR>', { silent = true })
keymap('v', '<F28>', ':VSSplit<CR>', { silent = true })
keymap({ 'n', 'i' }, '<F6>', '<ESC>:NERDTreeToggle<CR>', { silent = true })
keymap({ 'n', 'i' }, '<C-F6>', '<ESC>:GundoToggle<CR>', { silent = true })
keymap({ 'n', 'i' }, '<F7>', '<C-O>:TagbarToggle<CR>', { silent = true })
keymap({ 'n', 'i' }, '<F4>', '<C-O>za', { silent = true })
keymap({ 'n', 'i' }, '<F10>', '<C-O>:SSave! ~quicksave<CR>', { silent = true })
keymap({ 'n', 'i' }, '<C-F10>', '<C-O>:SLoad ~quicksave<CR>', { silent = true })
keymap({ 'n', 'i' }, '<S-F10>', '<ESC>:Startify<CR>', { silent = true })

-- Git mappings
keymap('n', 'gf', ':Gdiff<CR>', { silent = true })
keymap('n', 'gs', ':Git<CR>', { silent = true })
keymap('n', 'gp', ':Git pull<CR>', { silent = true })
keymap('n', 'gw', ':Gwrite<CR>', { silent = true })
keymap('n', 'gb', ':GBrowse<CR>', { silent = true })
keymap('n', 'gl', ':Git blame<CR>', { silent = true })
keymap('n', 'gc', ':Git commit | startinsert<CR>', { silent = true })
keymap('n', 'gu', ':Git reset --soft HEAD~1 | redraw<CR>', { silent = true })

-- GitGutter
keymap('n', '<M-\\>', ':GitGutterToggle<CR>', { silent = true })

-- Indent guides
keymap('n', '<C-\\>', ':IndentGuidesToggle<CR>', { silent = true })

-- Tabular
keymap({ 'n', 'i', 'v' }, '<F27>', '<C-O>:Tabularize /|<CR>', { silent = true })

-- Visual selection tools
keymap('v', '<F15>', ':<C-U>set textwidth=100<CR> | gv | gq | :<C-U>set textwidth=0<CR>', { silent = true })
keymap('v', '<F35>', ':sort u<CR>', { silent = true })

-- Python execution
keymap('n', '<F9>', ':w<CR>:exec "!python" shellescape(@%, 1)<CR>', { silent = true })

-- Bash support
vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    keymap('n', '<F8>', ':BashCheck<CR>', { buffer = true, silent = true })
    keymap('n', '<F9>', ':Bash<CR>', { buffer = true, silent = true })
  end,
})

-- Whitespace commands
keymap('n', 'ww', ':StripWhitespace<CR>')
keymap('n', 'wt', ':ToggleWhitespace<CR>')
keymap('n', 'ws', ':ToggleStripWhitespaceOnSave<CR>')

-- Virtual environments
keymap('n', 'vl', ':VirtualEnvList<CR>', { silent = true })
keymap('n', 'vd', ':VirtualEnvDeactivate<CR>', { silent = true })

-- External command aliases
keymap('n', 'tt', ':Gcd / | Silent tig<CR>', { silent = true })
keymap('n', 'th', ':Gcd / | Silent tig %<CR>', { silent = true })
keymap('n', 'ls', '!ls -Alhv --group-directories-first<CR>')

-- ❰❰ Commands ❱❱
vim.api.nvim_create_user_command('Silent', function(opts)
  vim.cmd('silent !' .. opts.args)
  vim.cmd('redraw!')
end, { nargs = 1 })

vim.api.nvim_create_user_command('Jsonify', '%!jq .', {})
vim.api.nvim_create_user_command('PF', 'w! | Pytest function', {})
vim.api.nvim_create_user_command('PFV', 'w! | Pytest function verbose', {})
vim.api.nvim_create_user_command('PT', 'w! | Pytest file', {})
vim.api.nvim_create_user_command('PTV', 'w! | Pytest file verbose', {})
vim.api.nvim_create_user_command('PP', 'w! | Pytest project', {})
vim.api.nvim_create_user_command('PPV', 'w! | Pytest project verbose', {})
vim.api.nvim_create_user_command('PS', 'Pytest session', {})
vim.api.nvim_create_user_command('PL', 'Pytest fails', {})
vim.api.nvim_create_user_command('PD', 'Pytest projecttestwd', {})
vim.api.nvim_create_user_command('VA', 'VirtualEnvActivate', {})
vim.api.nvim_create_user_command('BN', 'new', {})
vim.api.nvim_create_user_command('TD', 'tabclose', {})
vim.api.nvim_create_user_command('TN', 'tabnew | vsp', {})

-- ❰❰ Autocommands ❱❱
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- File type associations
autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.ejs",
  command = "set filetype=html",
})

autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.less",
  command = "set filetype=css",
})

autocmd({ "BufReadPost" }, {
  pattern = "*.dwc",
  command = "set syntax=xml",
})

-- Filetype-specific indentation
autocmd("FileType", {
  pattern = { "html", "javascript", "json", "lua", "vim", "vue", "yaml" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
    vim.opt_local.tabstop = 2
  end,
})

-- Fish compiler
autocmd("FileType", {
  pattern = "fish",
  command = "compiler fish",
})

-- Disable undo for temp files
autocmd("BufWritePre", {
  pattern = "/tmp/*",
  command = "setlocal noundofile",
})

-- Color scheme highlights
autocmd({ "VimEnter", "Colorscheme" }, {
  callback = function()
    vim.cmd("hi VertSplit ctermfg=237 ctermbg=235")
    vim.cmd("hi Normal ctermbg=NONE")
    vim.cmd("hi nonText ctermbg=NONE")
    vim.cmd("hi ColorColumn ctermbg=235")
    vim.cmd("hi IndentGuidesOdd ctermbg=237")
    vim.cmd("hi IndentGuidesEven ctermbg=235")
  end,
})

-- Startify integration
autocmd("User", {
  pattern = "Startified",
  command = "setlocal buftype=",
})

autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 then
      vim.cmd("Startify")
      vim.cmd("NERDTree")
      vim.cmd("wincmd w")
    end
  end,
})

-- Large file handling
local large_file_group = augroup("LargeFile", { clear = true })
local large_file_size = 1024 * 1024 * 10 -- 10MB

autocmd("BufReadPre", {
  group = large_file_group,
  callback = function()
    local file = vim.fn.expand("<afile>")
    if vim.fn.getfsize(file) > large_file_size then
      vim.opt_local.eventignore:append("FileType")
      vim.opt_local.swapfile = false
      vim.opt_local.bufhidden = "unload"
      vim.opt_local.buftype = "nowrite"
      vim.opt_local.undolevels = -1
    else
      vim.opt_local.eventignore:remove("FileType")
    end
  end,
})

-- Tagbar type definitions
vim.g.tagbar_type_make = {
  kinds = {
    'm:macros',
    't:targets'
  }
}

vim.g.tagbar_type_markdown = {
  ctagstype = 'markdown',
  kinds = {
    'h:Heading_L1',
    'i:Heading_L2',
    'k:Heading_L3'
  }
}

-- tComment leader
vim.g.tcomment_opleader1 = 'tc'
