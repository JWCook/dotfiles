-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ❰❰ Large File Handling ❱❱
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local large_file_group = augroup("LargeFile", { clear = true })
local large_file_size = 1024 * 1024 * 10 -- 10MB

-- Handle large files
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

-- Set tab width to 2 for specific filetypes
local tab_width_group = augroup("TabWidth", { clear = true })
autocmd("FileType", {
  group = tab_width_group,
  pattern = { "html", "javascript", "json", "lua", "typescript", "vim", "vue", "yaml" },
  callback = function()
    vim.schedule(function()
      vim.opt_local.shiftwidth = 2
      vim.opt_local.softtabstop = 2
      vim.opt_local.tabstop = 2
    end)
  end,
})

-- Tagbar Type Definitions
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
