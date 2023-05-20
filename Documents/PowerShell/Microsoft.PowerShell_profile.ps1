Set-PoshPrompt -Theme ~\.mytheme.omp.json # Set theme (uses oh-my-posh)
Invoke-Expression (& {$hook = if ($PSVersionTable.PSVersion.Major -lt 6) {'prompt'} else {'pwd'} ; (zoxide init --hook $hook powershell | Out-String)}) # Init zoxide

# Aliases
function ..() {cd ..}
Set-Alias -Name cut -Value hck
Set-Alias -Name cat -Value bat
Set-Alias -Name sed -Value sd
Set-Alias -Name ls -Value lsd
Set-Alias -Name vim -Value nvim
Set-Alias -Name tldr -Value tealdeer-windows-x86_64-msvc
function ll([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {lsd -lhat $Remaining}
function dif([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {delta -ns $Remaining}
function vimdiff([string[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {vim -d $Remaining}
function readerPandoc([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {pandoc -f html -t plain $Remaining} # Parses a webpage to text

# Autocomplete
# If bat is installed, previews are syntax-highlighted, can be scrolled using ctl+up/down
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock {Invoke-FzfTabCompletion}

# Some utility functions
function updateAll() {
  scoop update *
  vim +PlugUpgrade +PlugUpdate +PlugInstall +PlugClean +CocInstall +CocUpdateSync +qall
  Update-Module # Update PowerShell modules
  Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod # Update Windows Store apps
  winget upgrade --all
  Get-WindowsUpdate ; Install-WindowsUpdate
}

function backupAll() {
  $backup_path = Resolve-Path "~/OneDrive/Backups"
  scoop export > $backup_path/Apps/scoop.txt;
  winget export -o $backup_path/Apps/winget.json;
  Get-AppxPackage | Select Name, PackageFullName | Format-Table -AutoSize > $backup_path/Apps/windows_store.txt;
  winget list | rg -v "winget" > $backup_path/Apps/windows_regular.txt;
  & "$backup_path/syncToExternal.ps1";
}

function condaStart() {
  #region conda initialize
  (& "~\anaconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
  #endregion
}
