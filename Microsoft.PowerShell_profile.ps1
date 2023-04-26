oh-my-posh init pwsh --config ~/.mytheme.omp.json | Invoke-Expression # Set theme (uses oh-my-posh)

# Aliases
Set-Alias -Name sed -Value sd

Set-Alias -Name vim -Value nvim
function vimdiff([string[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {
	vim -d $Remaining
}

Set-Alias -Name ls -Value lsd 
function ll([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {
	lsd -lhat $Remaining
}

function dif([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {
	delta -ns $Remaining
}

function readerPandoc([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {
	# Parses a webpage for reading in the terminal
	# Relies on pandoc (winget install pandoc)
	pandoc -f html -t plain $Remaining
}

# Autocomplete (uses PSReadLine)
Set-PSReadLineOption -PredictionSource HistoryAndPlugin 
# Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -PredictionViewStyle ListView
# Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Autocomplete (uses PSFzf)
# If bat is installed, will show syntax-highlighted previews
# Previews can be scrolled using ctrl+up/down arrows
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# For zoxide v0.8.0+
Invoke-Expression (& {
	$hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
	(zoxide init --hook $hook powershell | Out-String)
})

function updateAll() {
	# Update-Module updates PowerShell modules
	# The last command ("Get-CimInstance ...") updates Windows Store programs
	scoop update * ; winget upgrade --all ; vim +PlugUpgrade +PlugUpdate +PlugInstall +PlugClean +CocInstall +CocUpdateSync +qall ; Get-WindowsUpdate ; Install-WindowsUpdate ; Update-Module ; Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod ;
}

$backup_path = Resolve-Path "~/OneDrive/Backups"
function backupAll() {
	scoop export > $backup_path/Apps/scoop.txt;
	winget export -o $backup_path/Apps/winget.json;
	Get-AppxPackage | Select Name, PackageFullName | Format-Table -AutoSize > $backup_path/Apps/windows_store.txt;
	winget list | rg -v "winget" > $backup_path/Apps/windows_regular.txt;
	& "$backup_path/syncToExternal.ps1";
}

function condaStart() {
	#region conda initialize
	# !! Contents within this block are managed by 'conda init' !!
	(& "~\anaconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
	#endregion
}
