-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- ❰❰ General Settings ❱❱
-- vim.opt.conceallevel = 0
vim.opt.shada = "'100,<50,s10,h"
vim.opt.mouse = ""
vim.opt.backup = false
vim.opt.sessionoptions:remove({ "options", "folds" })
vim.opt.timeoutlen = 200
vim.opt.ttimeoutlen = 50
vim.opt.wildignore =
"*/__pycache__/*,*/.tox/*,*.o,*.a,*~,*.class,*.gif,*.jpg,*.la,*.mo,*.obj,*.png,*.pyc,*.so,*.sw*,*.xpm"
vim.opt.scrolloff = 1
vim.opt.sidescrolloff = 5
vim.opt.undodir = vim.env.HOME .. "/.vim/undo"
vim.opt.undofile = true
vim.opt.laststatus = 2

-- ❰❰ Colors and Fonts ❱❱
vim.opt.termguicolors = true
vim.opt.background = "dark"
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
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
vim.opt.showmatch = true
vim.opt.mat = 2

-- ❰❰ Buffers/Windows/Tabs ❱❱
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.hidden = true

-- ❰❰ Formatting & Folding ❱❱
vim.g.autoformat = false
vim.g.markdown_folding = 1

-- ❰❰ NetRW ❱❱
vim.g.netrw_keepdir = 0
