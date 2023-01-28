# General
# --------------------

Function func_ll {Get-ChildItem -l .}
Set-alias ll func_ll


# Application aliases
# --------------------

Set-Alias subl "$env:Programfiles\Sublime Text\sublime_text.exe"


# Git
# --------------------

Function func_gadd {git add .}
Set-alias gadd func_gadd

Function func_gs {git status}
Set-alias gs func_gs

Function func_gf {git fetch --all}
Set-alias gf func_gf

Function func_gp {git pull}
Set-alias gp func_gp -force -option 'Constant','AllScope'

Function func_gpp {git pull; git fetch --prune}
Set-alias gpp func_gpp

Function func_gfpush {git push --force}
Set-alias gfpush func_gfpush

function func_gsw {
    param([Parameter()] [String]$branch)
    git switch $branch
}
Set-alias gsw func_gsw

function func_gsc {
    param([Parameter()] [String]$branch)
    git switch -c $branch
}
Set-alias gsc func_gsc

Function func_gmend {git commit --amend}
Set-alias gmend func_gmend

Function func_grebase {git rebase -i main}
Set-alias grebase func_grebase

Function func_gunstage {git reset HEAD}
Set-alias gunstage func_gunstage

Function func_guncommit {git reset --soft HEAD~}
Set-alias guncommit func_guncommit


# File associations
# --------------------

Function func_export_associations {
    Dism /Online /Export-DefaultAppAssociations:"D:\Nextcloud\Data\Config\WinAppAssociations.xml"
}

Function func_import_associations {
    Dism /Online /Import-DefaultAppAssociations:"D:\Nextcloud\Data\Config\WinAppAssociations.xml"
}
