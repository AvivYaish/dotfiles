oh-my-posh init pwsh --config ~\.mytheme.omp.json | Invoke-Expression # Set theme (uses oh-my-posh)
Invoke-Expression (& {$hook = if ($PSVersionTable.PSVersion.Major -lt 6) {'prompt'} else {'pwd'} ; (zoxide init --hook $hook powershell | Out-String)}) # Init zoxide

# Aliases
function ..() {cd ..}
Set-Alias -Name ls -Value lsd
Set-Alias -Name du -Value dust
Set-Alias -Name cut -Value hck
Set-Alias -Name cat -Value bat
Set-Alias -Name sed -Value sd
Set-Alias -Name vim -Value nvim
Set-Alias -Name tldr -Value tealdeer-windows-x86_64-msvc
function ll([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {lsd -lhat $Remaining}
function dif([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {delta -ns $Remaining}
function vimdiff([string[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {vim -d $Remaining}
function readerPandoc([String[]] [Parameter(Position=1, ValueFromRemainingArguments)] $Remaining) {pandoc -f html -t plain $Remaining} # Parses a webpage to text

# Autocomplete
# If bat is installed, previews are syntax-highlighted, can be scrolled using ctl+up/down
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock {Invoke-FzfTabCompletion}
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView