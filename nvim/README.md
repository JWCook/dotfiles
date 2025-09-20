# Neovim Custom Keymap Reference

## Movement
| Action                         | Keymap            | Description
| ------                         | ------            | -----------
| Move up/down (line wrap)       | `<C-Up>/<C-Down>` | Navigate considering line wrapping
| Move up/down (visual wrap)     | `<C-k>/<C-j>`     | Navigate considering line wrapping

## Buffers
| Action               | Keymap             | Command
| ------               | ------             | -------
| Previous buffer      | `<C-Left>/<C-h>`   | `:bprev`
| Next buffer          | `<C-Right>/<C-l>`  | `:bnext`
| Close buffer         | `:BD`              | `:Bdelete`

## Windows
| Action               | Keymap                    | Command
| ------               | ------                    | -------
| Navigate windows     | `<A-Up/Down/Left/Right>`  | `:wincmd [kjhl]`
| Navigate windows     | `<A-k/j/h/l>`             | `:wincmd [kjhl]`
| Resize windows       | `<M-+/-/=>`               | `:wincmd [+-=]`
| Maximize window      | `<C-x>`                   | `:resize 45 \| vertical resize 100`
| Vertical split       | `vv`                      | `<C-w>v`
| Horizontal split     | `hh`                      | `<C-w>s`

## Tabs
| Action               | Keymap                    | Command
| ------               | ------                    | -------
| New tab              | `:TN`                     | `:tabnew`
| Close tab            | `:TD`                     | `:tabclose`
| Previous/next tab    | `<S-Left>/<S-Right>`      | `:tabp/:tabn`
| Move tab left/right  | `<C-S-Left>/<C-S-Right>`  | `:tabm -1/:tabm +1`

## Misc Plugins & Commands (F-keys)
| Action                    | Keymap    | Command
| ------                    | ------    | ------
| Neovim help               | `<F1>`    | `:help`
| Search Help tags          | `<C-F1>`  | `:Telescope help_tags`
|                           | `<F2>`    |
| Toggle comment            | `<F3>`    | `gc`
| Toggle fold               | `<F4>`    | `za`
| Search filenames          | `F5`      | `:Telescope find_files`
| Search file content       | `<C-F5>`  | `:Telescope live_grep`
| Search buffers            | `<S-F5>`  | `:Telescope buffers`
| Search recent filenames   | `<A-F5>`  | `:Telescope oldfiles`
| Toggle file tree          | `<F6>`    | `:Neotree toggle`
| Toggle undo tree          | `<C-F6>`  | `:UndotreeToggle`
| Toggle tagbar             | `<F7>`    | `:TagbarToggle`
| Toggle diagnostics        | `<F8>`    | `:Trouble diagnostics toggle`
| Toggle symbols            | `<C-F8>`  | `:Trouble symbols toggle`
| Toggle terminal           | `<F9>`    |
| Yank history              | `<F10>`   | `:YankyRingHistory`
| Sync plugins              | `<F12>`   | `:Lazy sync`
| Open LazyVim              | `<C-F12>` | `:Lazy`

## LSP & Code Actions
| Action                  | Keymap         | Description
| ------                  | ------         | -----------
| Go to definition        | `gd`           | Jump to symbol definition
| Go to declaration       | `gD`           | Jump to symbol declaration
| Find references         | `gr`           | Show all references
| Go to implementation    | `gi`           | Jump to implementation
| Hover documentation     | `K`            | Show documentation
| Signature help          | `<leader>ck`   | Show function signature
| Code actions            | `<leader>ca`   | Available code actions
| Rename symbol           | `<leader>cr`   | Rename current symbol
| Format code             | `<leader>cf`   | Format current buffer

## Diagnostics
| Action                  | Keymap         | Command
| ------                  | ------         | -----------
| Toggle trouble          | `<leader>tt`   | `:Trouble diagnostics toggle`
| Buffer diagnostics      | `<leader>td`   | `:Trouble diagnostics toggle filter.buf=0`
| Symbols                 | `<leader>ts`   | `:Trouble symbols toggle focus=false`
| Previous diagnostic     | `[d`           |
| Next diagnostic         | `]d`           |
| Show line diagnostics   | `<leader>cd`   |
| Diagnostics to loclist  | `<leader>cq`   |

## Git Commands
| Action               | Keymap        | Command
| ------               | ------        | -------
| Git diff             | `gf`          | `:Gdiff`
| Git status           | `gs`          | `:Git`
| Git pull             | `gp`          | `:Git pull`
| Git write (add)      | `gw`          | `:Gwrite`
| Git blame            | `gl`          | `:Git blame`
| Git commit           | `gc`          | `:Git commit \| startinsert`
| Undo last commit     | `gu`          | `:Git reset --soft HEAD~1`

## Git Hunks
| Action               | Keymap         | Command
| ------               | ------         | -------
| Toggle git signs     | `<M-\\>`       | `:Gitsigns toggle_signs`
| Next hunk            | `]c`           | `:Gitsigns next_hunk`
| Previous hunk        | `[c`           | `:Gitsigns prev_hunk`
| Stage hunk           | `<leader>hs`   | `:Gitsigns stage_hunk`
| Reset hunk           | `<leader>hr`   | `:Gitsigns reset_hunk`
| Preview hunk         | `<leader>hp`   | `:Gitsigns preview_hunk`

## External Commands
| Action               | Keymap        | Command
| ------               | ------        | -------
| Run Python file      | `py`          | `python $1`
| Open tig             | `tt`          | `tig`
| Tig current file     | `th`          | `tig $1`
| List files           | `ll`          | `ls -Al`

## Whitespace
| Action               | Keymap        | Description
| ------               | ------        | -----------
| Trim whitespace      | `ww`          | Remove trailing whitespace
| Toggle whitespace    | `wt`          | Toggle whitespace highlighting
