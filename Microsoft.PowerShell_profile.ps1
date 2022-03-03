# Installation
# winget install JanDeDobbeleer.OhMyPosh	# Has nice p10k-like theme
# Install-Module PSWindowsUpdate 		# Update windows using 'Get-WindowsUpdate ; Install-WindowsUpdate'
# Install-Module PSReadLine			# Nicer PowerShell auto-completion
# Install-Module -Name PSFzf 			# fzf integration with PowerShell
# iwr -useb get.scoop.sh | iex			# Install 'scoop' package manager
# # sudo allows sudoing in Windows
# foreach ($app in @('sudo', '7zip', 'chezmoi', 'bat', 'lsd', 'ripgrep', 'sd', 'universal-ctags', 'neovim', 'ripgrep', 'fd', 'tldr', 'fzf', 'lf', 'curlie', 'procs', 'bottom', 'tre-command', 'glow') {
# 	scoop install $app
# }
#
# Other niceties:
# - cargo install viu 				# A cross-platform terminal image viewer
# - [epy](https://github.com/wustho/epy) 	# CLI ebook reader.
# - [reader](https://github.com/mrusme/reader) 	# CLI webpage reader.
#
# I put non-packaged apps in ${HOME}\.local\bin, and add the path to PATH.

Set-PoshPrompt -Theme ~\.mytheme.omp.json # Set theme (uses oh-my-posh)

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

function updateStoreApps() {
	 Get-CimInstance -Namespace "Root\cimv2\mdm\dmmap" -ClassName "MDM_EnterpriseModernAppManagement_AppManagement01" | Invoke-CimMethod -MethodName UpdateScanMethod
}

function updateAll() {
	scoop update * ; winget upgrade --all ; vim +PlugUpgrade +PlugUpdate +PlugInstall +PlugClean +CocUpdate +qall ; updateStoreApps ; Get-WindowsUpdate ; Install-WindowsUpdate
}

$backup_path = "D:/OneDrive/Backups"
function backupAll() {
	scoop export > $backup_path/scoop.txt;
	winget export -o $backup_path/winget.json;
	Get-AppxPackage | Select Name, PackageFullName | Format-Table -AutoSize > $backup_path/windows_store.txt;
	winget list | rg -v "winget" > $backup_path/windows_regular.txt;
	$backup_path/syncToExternal.ps1;
}

function condaStart() {
	#region conda initialize
	# !! Contents within this block are managed by 'conda init' !!
	(& "C:\Users\darti\anaconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
	#endregion
}
