# Installation
# winget install JanDeDobbeleer.OhMyPosh	# Has nice p10k-like theme
# Install-Module PSReadLine			# Nicer PowerShell auto-completion
# Install-Module -Name PSFzf 			# fzf integration with PowerShell
# iwr -useb get.scoop.sh | iex			# Install 'scoop' package manager
# foreach ($app in @('chezmoi', 'bat', 'lsd', 'ripgrep', 'universal-ctags', 'neovim', 'ripgrep', 'fd', 'tldr', 'curlie', 'procs') {
# 	scoop install $app
# }
# # 7zip is installed with curlie for some reason

# Aliases
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

# Set theme (uses oh-my-posh)
Set-PoshPrompt -Theme ~\.mytheme.omp.json

# Autocomplete (uses PSReadLine)
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -EditMode Windows
Set-PSReadLineOption -PredictionViewStyle ListView
# Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Autocomplete (uses PSFzf)
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# For zoxide v0.8.0+
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\Users\darti\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion
