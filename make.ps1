$dotfiles = "D:\Workspace\dotfiles"
$profile_src = "$dotfiles\powershell\powershell_aliases.ps1"

$win_docs = [Environment]::GetFolderPath("MyDocuments")
$profile_dir = "$win_docs\WindowsPowerShell"
$profile_dest = "$profile_dir\Microsoft.PowerShell_profile.ps1"


If (!(test-path $profile_dir)) {
    md $profile_dir
}

If (test-path $profile_dest) {
    rm $profile_dest
}


New-Item -ItemType SymbolicLink  -Path $profile_dest -Target $profile_src