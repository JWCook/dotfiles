return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- Configure markdown concealing to hide bold/italic but show code block backticks
      require('vim.treesitter.query').set(
        'markdown',
        'highlights',
        [[
;From tree-sitter-grammars/tree-sitter-markdown
[
 (fenced_code_block_delimiter)
] @punctuation.delimiter
]]
      )

      return opts
    end,
  },
}
