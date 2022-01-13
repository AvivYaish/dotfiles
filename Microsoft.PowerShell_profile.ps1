# Alias for nvim
Set-Alias -Name vim -Value nvim
function vimdiff([string[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {
	vim -d $Remaining
}

Set-Alias -Name ls -Value lsd 
function ll([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {
	lsd -l $Remaining
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
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\Users\darti\miniconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion
