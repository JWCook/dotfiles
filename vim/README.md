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
| git commit         | gc    | `:Gcommit`
| undo last commit   | gu    | `:Git reset --soft HEAD~1`
| git move (+file)   |       | `:Gmove`
| git remove (+file) |       | `:Gremove`
| git push           |       | `:Gpush`
| Git add + wq       |       | `:Gwq`
| Git cd repo        |       | `:Gcd`

# Plugins
| Plugin       | Action                     | Alias    | Command
| ------       | ------                     | -----    | -------
| tComment     | Toggle                     | F3       | `:TComment[Block]`
| Tabular      | Align Markdown Table       | Ctrl-F3  | `:Tabularize /[char]`
| Visual Split | Resize to visual selection | F4       | `:VSResize`
|              | Split to visual selection  | Ctrl-F4  | `:VSSplit`
| Folding      | Toggle                     | F4 (n,i) | za
| NERD Tree    | Toggle (left vsplit)       | F6
|              | open selected in split     | i
|              | open selected in vsplit    | s
|              | refresh all                | R
|              | change wd to selected      | cd
|              | change root to selected    | C
|              | change root to `..`        | u
|              | show hidden files          | I
|              | Maximize/Minimize window   | A
| Gundo        | Toggle (left vsplit)       | Ctrl-F6
| Tagbar       | Toggle (right vsplit)      | F7
|              | Zoom                       | x
| Pep8         | Check                      | F8
|              | Clear markers              | Ctrl-F8
| Startify     | Quicksave                  | F10      | `:SSave ~quicksave`
|              | Load quicksave             | Ctrl-F10 | `:Sload  ~quicksave`
|              | Open Startify              | Shift-F1 | `:Startify`
|              | Load session               |          | `:SLoad [name]`
|              | Save session               |          | `:SSave [name]`
|              | Delete session             |          | `:SDelete [name]`
|              | Save/close session         |          | `:SClose`
| Plug         | Update plugins             | F12
|              | Plugin status              | Ctrl-F12
| Misc toggles | Indent guides              | Ctrl-\
|              | GitGutter                  | Alt-\
| Pytest       | run current func           | pf       | `:Pytest function [verbose]`
|              | run current file           | pt       | `:Pytest file     [verbose]`
|              | run all in project         | pp       | `:Pytest project  [verbose]`
|              | last session               | ps       | `:Pytest session`
|              | last failures              | pl       | `:Pytest fails`
|              | see test dir               | pd       | `:Pytest projecttestwd`
| Whitespace   | Strip whitespace           | ww       | `:StripWhitespace`
|              | Toggle Markers             | wt       | `:ToggleWhitespace`
|              | Strip on save              | ws       | `:ToggleStripWhitespaceOnSave`
| Unite        | File search                | Ctrl-P
|              | Buffer search              | Ctrl-B
|              | Content search             | Ctrl-F
|              | Git Content search         | Ctrl-G
|              | Yank hist search           | Ctrl-Y
|              | Refresh cache              | Ctrl-L
| Virtualenvs  | list                       | vl       | `:VirtualEnvList`
|              | deactivate                 | vd       | `:VirtualEnvDeactivate`
|              | activate                   |          | `:VirtualEnvActivate [name/tab-complete]`


# General Reference

| Category          | Action                         | Command                              | Example
| --------          | ------                         | -------                              | -------
| Movement          | beginning of line              | 0
|                   | end of line                    | $$
|                   | beginning/end of file          | gg/G
|                   | show current line #            | Ctrl-G
|                   | goto line #                    | ##G
|                   | goto matching bracket `(){}{}` | %
| Copy/Paste        | Delete line                    | dd
|                   | Copy (yank)                    | y
|                   | Copy line                      | Y OR yy
|                   | Paste after                    | p
|                   | Paste before                   | P
|                   | Set paste mode                 | \p
|                   | Replace between markers        | ci[mark]                             | ci" (between quotes) | ci[ (between brackets)
|
| Search/Replace    | Search                         | /pattern
|                   | copy from here to str          | y/pattern
|                   | next/prev result               | n/N
|                   | clear search highlights        | \b
|                   | indent/unindent line           | >> / <<
|                   | Substistutions                 | :s/find/replace
|                   | Global                         | :%s/find/replace/g
|                   | With confirmation              | :%s/find/replace/gc
| Marks             | m[a-z]
|                   | goto a line beginning          | 'a
|                   | goto a exact location          | `a
|                   | copy from here to a            | y`a
| Registers         | "[a-z]
|                   | copy to register a             | "ay
| Buffers           | movement                       | Ctrl+Left/Right
|                   | New buffer                     | :BN OR :new
|                   | open file in new buffer        | :e [filename]
|                   | open inactive buffer           | :badd [filename]
|                   | list open buffers              | :buffers
|                   | switch buffer (by #)           | :b[#]                                | :b1
|                   | switch buffer (by file)        | :b [filename]                        | :b text.txt
|                   | close current buffer           | :bd
|                   | close buffer                   | :bd[#] OR :bd [filename]
|                   | close buffer w/o window        | :BD OR \q
|                   | close buffer range             | :<x,y>bd                             | :5,6bd
| Windows (Splits)  | movement                       | Alt+Up/Down/Left/Right
|                   | open vim w/ vert split         | vim -O2 <filename1> ... <filename n>
|                   | (h) split                      | :hh                                  | [N]sp  Ex            | :2sp
|                   | (v) split                      | :vv                                  | [N]vsp
|                   | open file in new split         | :[v]sp <filename>
|                   | close current window           | :q
|                   | resize split                   | Alt -/+/=                            | Ctrl-W, -/+/=
| Tabs              | movement                       | Shift+Left/Right
|                   | list tabs                      | :tabn
|                   | new tab                        | :TN                                  | :tabnew
|                   | new tab w/ file                | :tabnew <filename>
|                   | close tab                      | :TD                                  | :tabclose
| Sessions          | save session                   | :mksession <filename>
|                   | resume session                 | :source <filename>                   | vim -S <filename>
| External commands | :!<command>                    | :r !ls (insert results of ls)
