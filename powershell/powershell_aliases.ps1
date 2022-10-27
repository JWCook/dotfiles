Function func_gs {git status}
Set-alias gs func_gs

Function func_gp {git pull}
Set-alias gp func_gp -force -option 'Constant','AllScope'

Function func_gsw {git switch}
Set-alias gsw func_gsw

Function func_gsw {git switch -c}
Set-alias gsc func_gsc

Function func_gmend {git commit --amend}
Set-alias gmend func_gmend

Function func_gunstage {gunstage git reset HEAD}
Set-alias gunstage func_gunstage

Function func_guncommit {gunstage git reset --soft HEAD~}
Set-alias guncommit func_guncommit

Function func_export_associations {
    Dism /Online /Export-DefaultAppAssociations:"D:\Nextcloud\Data\Config\WinAppAssociations.xml"
}

Function func_import_associations {
    Dism /Online /Import-DefaultAppAssociations:"D:\Nextcloud\Data\Config\WinAppAssociations.xml"
}
