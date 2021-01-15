# Vim Reference
Reference for vim commands, including custom commands, mappings, plugins, etc.

# Git
| Action             | Alias | Command
| ------             | ----- | -------
| tig history        | tig
| tig %              | tt
| git diff %         | gf    | `:Gdiff`
| git status         | gs    | `:Gstatus`
| * stage/unstage    | -
| * diff             | D
| * remove           | u
| * commit           | cc
| * refresh          | r
| git browse         | gb    | `:Gbrowse`
| git blame          | gl    | `:Gblame`
| git pull           | gp    | `:Gpull`
| git add %          | gw    | `:Gwrite`
| git checkout %     |       | `:Gread`
| git commit         | gc    | `:Gcommit`
| undo last commit   | gu    | `:Git reset --soft HEAD~1`
| git move (+file)   |       | `:Gmove`
| git remove (+file) |       | `:Gremove`
| git push           |       | `:Gpush`
| Git add + wq       |       | `:Gwq`
| Git cd repo        |       | `:Gcd`

# Plugins
| Plugin       | Action                     | Alias         | Command
| ------       | ------                     | -----         | -------
| tComment     | toggle comment (line/v)    | F3            | `:TComment[Block]`
| Tabular      | align Markdown Table       | Ctrl-F3       | `:Tabularize /[char]`
| Formatting   | wrap selected text         | Shift-F3
|              | sort lines (unique)        | Ctrl-Shift-F3 | :sort u
| Visual Split | resize to visual selection | F4            | `:VSResize`
|              | split to visual selection  | Ctrl-F4       | `:VSSplit`
| Folding      | toggle                     | F4 (n,i)      | za
| NERD Tree    | toggle (left vsplit)       | F6
|              | open selected in split     | i
|              | open selected in vsplit    | s
|              | refresh all                | R
|              | change wd to selected      | cd
|              | change root to selected    | C
|              | change root to `..`        | u
|              | show hidden files          | I
|              | maximize/Minimize window   | A
| Gundo        | toggle (left vsplit)       | Ctrl-F6
| Tagbar       | toggle (right vsplit)      | F7
|              | zoom                       | x
| Bash Support | Check bash syntax          | F8
| Pep8         | check                      | F8
|              | clear markers              | Ctrl-F8
| Startify     | quicksave                  | F10           | `:SSave ~quicksave`
|              | load quicksave             | Ctrl-F10      | `:Sload  ~quicksave`
|              | open Startify              | Shift-F10     | `:Startify`
|              | load session               |               | `:SLoad [name]`
|              | save session               |               | `:SSave [name]`
|              | delete session             |               | `:SDelete [name]`
|              | save/close session         |               | `:SClose`
| Plug         | update plugins             | F12
|              | plugin status              | Ctrl-F12
| Misc toggles | indent guides              | Ctrl-\
|              | gitGutter                  | Alt-\
| Pytest       | run current func           | \pf[v]        | `:Pytest function [verbose]`
|              | run current file           | \pt[v]        | `:Pytest file     [verbose]`
|              | run all in project         | \pp[v]        | `:Pytest project  [verbose]`
|              | last session output        | \ps           | `:Pytest session`
|              | last session failures      | \pl           | `:Pytest fails`
|              | see test dir               | \pd           | `:Pytest projecttestwd`
| Whitespace   | strip whitespace           | ww            | `:StripWhitespace`
|              | toggle Markers             | wt            | `:ToggleWhitespace`
|              | strip on save              | ws            | `:ToggleStripWhitespaceOnSave`
| Denite       | file search                | Ctrl-P        | `:DeniteProjectDir -start-filter file/rec`
|              | buffer search              | Ctrl-B
|              | content search (`ag`)      | Ctrl-F
|              | `git` search               | Ctrl-G
|              | yank history search        | Ctrl-Y
|              | refresh cache              | Ctrl-L
|              | command history search         | Ctrl-Shift-R
| Virtualenvs  | list                       | vl            | `:VirtualEnvList`
|              | deactivate                 | vd            | `:VirtualEnvDeactivate`
|              | activate                   |               | `:VirtualEnvActivate [name/tab-complete]`


# General Reference

| Category          | Action                         | Command                      | Example
| --------          | ------                         | -------                      | -------
| Movement          | beginning/end of line          | 0 , $
|                   | (non-blank) beginning of line  | ^
|                   | beginning/end of file          | gg , GG
|                   | show current line #            | Ctrl-G
|                   | goto line #                    | ``:[#]`` OR  [#]G
|                   | goto last change               | ''
|                   | goto matching bracket `(){}{}` | %
| Copy/Paste        | delete line                    | dd
|                   | copy (yank)                    | y
|                   | copy line                      | Y OR yy
|                   | paste after                    | p
|                   | paste before                   | P
|                   | set paste mode                 | \p
|                   | replace between markers        | ci[mark]                     | ci" (between quotes) OR ci[ (between brackets)
|                   | yank history                   | Ctrl-Y
| Search/Replace    | search                         | /[pattern]
|                   | copy from here to str          | y/[pattern]
|                   | next/prev result               | n , N
|                   | clear search highlights        | \b
|                   | indent/unindent line           | >> , <<
|                   | substistutions                 | `:s/find/replace`
|                   | sub (append)                   | `:s/find/&append`
|                   | sub (w/ capture groups)        | `:s/\(find1\)\(find2\)/\1\2`
|                   | sub (w/ confirmation)          | `:s/find/replace/c`
|                   | sub (whole line)               | `:s/find/replace/g`
|                   | sub (whole file)               | `:%s/find/replace/g`
|                   | delete matching lines          | `%g/find/d`
| Marks             | create mark                    | m[a-z]
|                   | goto a line beginning          | 'a
|                   | goto a exact location          | `a
|                   | copy from here to a            | y`a
| Registers         | "[a-z]
|                   | copy to register a             | "ay
| Buffers           | movement                       | Ctrl+Left/Right
|                   | buffer list                    | Ctrl-B
|                   | new (empty) buffer             | `:BN` OR `:new`
|                   | open file in new buffer        | `:e [filename]`
|                   | close current buffer           | `:bd`
|                   | close buffer (& keep window)   | `:BD` OR \q
| Windows (Splits)  | movement                       | Alt+Up/Down/Left/Right
|                   | open vim w/ vert split         | `vim -O2 [filenames]...`
|                   | horizontal split               | hh OR `:[N]sp`               | `:2sp`
|                   | vertical split                 | vv OR `:[N]vsp`
|                   | open file in new split         | `:[v]sp [filename]`
|                   | close current window           | `:q`
|                   | resize split                   | Alt -/+/=
| Tabs              | movement                       | Shift+Left/Right
|                   | list tabs                      | `:tabn`
|                   | new tab                        | `:TN` OR `:tabnew`
|                   | new tab w/ file                | `:tabnew [filename]`
|                   | close tab                      | `:TD` OR `:tabclose`
|                   | move tab to last position      | `:tabm`
| Visual Mode       | charwise/linewise/blockwise    | v, V, Ctrl-v
|                   | last visual selection          | gv
|                   | reformat paragraph             | gq
|                   | upper/lower/toggle case        | U , u, ~
|                   | indent/unindent                | > , <
|                   | format lines                   | Shift-F3
|                   | sort lines (unique)            | Ctrl-Shift-F3
|                   | block insert/append            | I, A                         | **I{str}<ESC>** inserts {str} at beginning of each line in block; **A{str}<ESC>** appends to end
|                   | remove selection from `ex` cmd | Ctrl-U
| Other ex commands | run external command           | `:![command]`
|                   | insert output of command       | `:r ![command]`
|                   | show non-default options       | `:set`
|                   | reload `.vimrc`                | `:so ~/.vimrc`
