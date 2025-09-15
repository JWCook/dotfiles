# Neovim Configuration Reference

This is a [LazyVim](https://www.lazyvim.org/) based configuration with custom plugins and keymaps.

## Custom Keymaps

Custom keymaps are defined in `lua/config/keymaps.lua` and override or extend LazyVim defaults.

### General Mappings
| Action                  | Keymap        | Command
| ------                  | ------        | -------
| Open nvim config        | `ev`          | `:vsplit ~/.config/nvim/init.lua`
| Reload nvim config      | `sv`          | `:luafile ~/.config/nvim/init.lua`
| Command mode            | `;`           | `:`
| Redraw screen           | `rr`          | `:redraw!`
| Clear search highlights | `<leader>b`   | `:nohlsearch`

### Movement
| Action                         | Keymap            | Description
| ------                         | ------            | -----------
| Move up/down (line wrap)       | `<C-Up>/<C-Down>` | Navigate considering line wrapping
| Move up/down (visual wrap)     | `<C-k>/<C-j>`     | Navigate considering line wrapping

### File Navigation (Telescope)
| Action               | Keymap        | Command
| ------               | ------        | -------
| Find files           | `<C-p>`       | `:Telescope find_files`
| Find files           | `<leader>ff`  | `:Telescope find_files`
| Live grep            | `<leader>fg`  | `:Telescope live_grep`
| Buffer list          | `<leader>fb`  | `:Telescope buffers`
| Help tags            | `<leader>fh`  | `:Telescope help_tags`
| Recent files         | `<leader>fr`  | `:Telescope oldfiles`

### LSP & Code Actions
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

### Diagnostics
| Action                  | Keymap         | Description
| ------                  | ------         | -----------
| Previous diagnostic     | `[d`           | Jump to previous diagnostic
| Next diagnostic         | `]d`           | Jump to next diagnostic
| Show line diagnostics   | `<leader>cd`   | Show diagnostics for current line
| Diagnostics to loclist  | `<leader>cq`   | Send diagnostics to location list

### Trouble (Diagnostics Viewer)
| Action                  | Keymap         | Command
| ------                  | ------         | -------
| Toggle trouble          | `<leader>tt`   | `:Trouble diagnostics toggle`
| Buffer diagnostics      | `<leader>td`   | `:Trouble diagnostics toggle filter.buf=0`
| Symbols                 | `<leader>ts`   | `:Trouble symbols toggle focus=false`

### Buffer Management
| Action               | Keymap             | Command
| ------               | ------             | -------
| Previous buffer      | `<C-Left>/<C-h>`   | `:bprev`
| Next buffer          | `<C-Right>/<C-l>`  | `:bnext`

### Window Management
| Action               | Keymap                    | Command
| ------               | ------                    | -------
| Navigate windows     | `<A-Up/Down/Left/Right>`  | `:wincmd [kjhl]`
| Navigate windows     | `<A-k/j/h/l>`             | `:wincmd [kjhl]`
| Resize windows       | `<M-+/-/=>`               | `:wincmd [+-=]`
| Maximize window      | `<C-x>`                   | `:resize 45 \| vertical resize 100`
| Vertical split       | `vv`                      | `<C-w>v`
| Horizontal split     | `hh`                      | `<C-w>s`

### Tab Management
| Action               | Keymap                    | Command
| ------               | ------                    | -------
| Previous/next tab    | `<S-Left>/<S-Right>`      | `:tabp/:tabn`
| Move tab left/right  | `<C-S-Left>/<C-S-Right>`  | `:tabm -1/:tabm +1`

### Plugin-Specific

#### File Explorer (Neo-tree)
| Action               | Keymap        | Command
| ------               | ------        | -------
| Toggle file tree     | `<F6>`        | `:Neotree toggle`

#### Undo Tree
| Action               | Keymap        | Command
| ------               | ------        | -------
| Toggle undo tree     | `<C-F6>`      | `:UndotreeToggle`

#### Tagbar (Code Outline)
| Action               | Keymap        | Command
| ------               | ------        | -------
| Toggle tagbar        | `<F7>`        | `:TagbarToggle`

#### Folding
| Action               | Keymap        | Command
| ------               | ------        | -------
| Toggle fold          | `<F4>`        | `za`

#### Plugin Updates
| Action               | Keymap        | Command
| ------               | ------        | -------
| Sync plugins         | `<F12>`       | `:Lazy sync`
| Open Lazy            | `<F24>`       | `:Lazy`

#### Terminal
| Action               | Keymap        | Command
| ------               | ------        | -------
| Toggle terminal      | `<F8>`        | `:ToggleTerm`

### Git Integration (Fugitive + Gitsigns)

#### Git Commands
| Action               | Keymap        | Command
| ------               | ------        | -------
| Git diff             | `gf`          | `:Gdiff`
| Git status           | `gs`          | `:Git`
| Git pull             | `gp`          | `:Git pull`
| Git write (add)      | `gw`          | `:Gwrite`
| Git blame            | `gl`          | `:Git blame`
| Git commit           | `gc`          | `:Git commit \| startinsert`
| Undo last commit     | `gu`          | `:Git reset --soft HEAD~1`

#### Git Hunks (Gitsigns)
| Action               | Keymap         | Command
| ------               | ------         | -------
| Toggle git signs     | `<M-\\>`       | `:Gitsigns toggle_signs`
| Next hunk            | `]c`           | `:Gitsigns next_hunk`
| Previous hunk        | `[c`           | `:Gitsigns prev_hunk`
| Stage hunk           | `<leader>hs`   | `:Gitsigns stage_hunk`
| Reset hunk           | `<leader>hr`   | `:Gitsigns reset_hunk`
| Preview hunk         | `<leader>hp`   | `:Gitsigns preview_hunk`

### Development Tools

#### Python
| Action               | Keymap        | Command
| ------               | ------        | -------
| Run Python file     | `<F9>`        | `:w<CR>:exec "!python" shellescape(@%, 1)`

#### External Commands
| Action               | Keymap        | Command
| ------               | ------        | -------
| Open tig             | `tt`          | `:!tig`
| Tig current file     | `th`          | `:!tig %`
| List files           | `ls`          | `!ls -Alhv --group-directories-first`

#### Whitespace Management
| Action               | Keymap        | Description
| ------               | ------        | -----------
| Trim whitespace      | `ww`          | Remove trailing whitespace
| Toggle whitespace    | `wt`          | Toggle whitespace highlighting

## LazyVim Default Keymaps

LazyVim provides many built-in keymaps. Key defaults include:

### Navigation
- `j/k` - Move up/down respecting line wrapping
- `<Ctrl-h/j/k/l>` - Navigate between windows
- `<Shift-h/l>` or `[b/]b` - Navigate between buffers

### Window Management
- `<Leader>-` - Split window below
- `<Leader>|` - Split window right
- `<Leader>wd` - Delete current window

### Editing
- `<Ctrl-s>` - Save file
- `<Alt-j/k>` - Move lines up/down
- `v` with `<`/`>` - Indent while maintaining selection

### Toggles
- `<Leader>uf` - Toggle formatting
- `<Leader>us` - Toggle spelling
- `<Leader>uw` - Toggle line wrap
- `<Leader>ul` - Toggle line numbers

### Git (LazyGit)
- `<Leader>gg` - Open Lazygit
- `<Leader>gb` - Git blame current line

### Misc
- `<Leader>qq` - Quit all
- `<Leader>L` - Open LazyVim changelog

## Additional Plugins

The configuration includes these additional plugins beyond LazyVim defaults:

- **vim-fugitive** - Git integration
- **undotree** - Undo history visualization
- **tagbar** - Code outline/navigation
- **yanky.nvim** - Enhanced yank/paste functionality
- **vim-bufkill** - Better buffer management
- **mini.trailspace** - Whitespace management
- **nvim-surround** - Text object manipulation
- **toggleterm.nvim** - Terminal integration
- **vim-tmux-navigator** - Tmux pane navigation

## General Vim Reference

### Basic Movement
| Command    | Action
| -------    | ------
| `0` / `$`  | Beginning/end of line
| `^`        | First non-blank character
| `gg` / `G` | Beginning/end of file
| `<Ctrl-g>` | Show current line number
| `:[#]` or `[#]G` | Go to line number
| `''`       | Go to last change
| `%`        | Go to matching bracket

### Copy/Paste/Edit
| Command      | Action
| -------      | ------
| `dd`         | Delete line
| `y` / `yy`   | Yank (copy)
| `p` / `P`    | Paste after/before
| `ci[marker]` | Change inside markers (e.g., `ci"`, `ci[`)

### Search/Replace
| Command                | Action
| -------                | ------
| `/[pattern]`           | Search forward
| `n` / `N`              | Next/previous search result
| `:s/find/replace`      | Substitute on current line
| `:%s/find/replace/g`   | Substitute in whole file
| `:s/find/replace/c`    | Substitute with confirmation

### Visual Mode
| Command         | Action
| -------         | ------
| `v` / `V` / `<Ctrl-v>` | Character/line/block visual mode
| `gv`            | Reselect last visual selection
| `gq`            | Reformat paragraph
| `U` / `u` / `~` | Upper/lower/toggle case
| `>` / `<`       | Indent/unindent
