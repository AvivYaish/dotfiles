# Installation
# I put non-packaged apps in ~\.local\bin, and add the path to PATH.

# Manual installation:
# - [reader](https://github.com/mrusme/reader) 	# CLI webpage reader.

foreach ($app in @('dbrgn.tealdeer', 'gerardog.gsudo', 'JanDeDobbeleer.OhMyPosh', '7zip.7zip', 'Anaconda.Anaconda3', 'BurntSushi.ripgrep.MSVC', 'Docker.DockerDesktop', 'Git.Git', 'Microsoft.WindowsTerminal', 'ajeetdsouza.zoxide', 'dandavison.delta', 'jftuga.less', 'junegunn.fzf', 'sharkdp.bat', 'sharkdp.fd', 'twpayne.chezmoi', 'Microsoft.PowerShell', 'Clement.bottom', 'ca.duan.tre-command', 'Microsoft.VisualStudioCode', 'JohnMacFarlane.Pandoc', 'OpenJS.NodeJS', 'Neovim.Neovim', 'UniversalCtags.Ctags', 'gokcehan.lf')) {
	winget install $app
}

# - PSWindowsUpdate 	# Update windows using 'Get-WindowsUpdate ; Install-WindowsUpdate'
# - PSReadLine		# Nicer PowerShell auto-completion
# - PSFzf 		# fzf integration with PowerShell
foreach ($app in @('PSWindowsUpdate', 'PSReadLine', 'PSFzf')) {
	Install-Module $app
}

iwr -useb get.scoop.sh | iex		# Install 'scoop' package manager, requires first setting execution policies, e.g. 'Set-ExecutionPolicy RemoteSigned -Scope CurrentUser'
scoop bucket add extras
foreach ($app in @('lsd', 'sd', 'curlie', 'procs', 'glow')) {
	scoop install $app
}

# visidata is a nice terminal spreadsheet tool, requires windows-curses
# pynvim is required to let neovim use python, for example for the vimspector debugger
foreach ($app in @('ptpython', 'visidata', 'windows-curses', 'epy-reader', 'pynvim')) {
	pip install $app
}

foreach ($app in @('viu')) {
	cargo install $app
}

# Configure PSFzf
# replace 'Ctrl+t' and 'Ctrl+r' with your preferred bindings:
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
# PSFzf can replace the standard tab completion
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }

# Make sure %PROFILE% points to Microsoft.PowerShell_profile.ps1, and that Windows Terminal's settings.json points to chezmoi's settings.json
# Notepad++: 
# 1. In Settings -> Style Configurator: Set global font, select Enable global font,
# 2. In Settings -> MISC. Enable DirectWrite (for ligatures),
# 3. In Settings -> Dark Mode: Enable dark mode,
# 4. In Settings -> Editing: Enable Multi-Editing, smooth font,
# 5. Set theme to my [1-Dark](https://github.com/AvivYaish/NAND2TET-1-Dark)

chezmoi init https://github.com/AvivYaish/dotfiles.git
chezmoi apply -v

# Set up neovim to use ~/.vimrc
vim -c "call mkdir(stdpath('config'),'p')" -c "call writefile(['set runtimepath^=~/.vim runtimepath+=~/.vim/after', 'let &packpath = &runtimepath', 'source ~/.vimrc'], stdpath('config').'/init.vim', 'a')" +qall
