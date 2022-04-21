# Installation
# I put non-packaged apps in ~\.local\bin, and add the path to PATH.

# Manual installation:
# - [reader](https://github.com/mrusme/reader) 	# CLI webpage reader.

foreach ($app in @('JanDeDobbeleer.OhMyPosh')) {
	winget install $app
}

# - PSWindowsUpdate 	# Update windows using 'Get-WindowsUpdate ; Install-WindowsUpdate'
# - PSReadLine		    # Nicer PowerShell auto-completion
# - PSFzf 		        # fzf integration with PowerShell
foreach ($app in @('PSWindowsUpdate', 'PSReadLine', 'PSWindowsUpdate', 'PSFzf')) {
	Install-Module $app
}

iwr -useb get.scoop.sh | iex		# Install 'scoop' package manager, requires first setting execution policies, e.g. 'Set-ExecutionPolicy RemoteSigned -Scope CurrentUser'
foreach ($app in @('sudo', '7zip', 'chezmoi', 'bat', 'lsd', 'ripgrep', 'sd', 'universal-ctags', 'neovim', 'ripgrep', 'fd', 'tldr', 'fzf', 'lf', 'curlie', 'procs', 'bottom', 'tre-command', 'glow')) {
	scoop install $app
}

# visidata is a nice terminal spreadsheet tool, requires windows-curses
foreach ($app in @('ptpython', 'visidata', 'windows-curses', 'epy-reader')) {
	pip install $app
}

foreach ($app in @('viu')) {
	cargo install $app
}
