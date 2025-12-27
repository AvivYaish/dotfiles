foreach ($app in @('Mozilla.Firefox', 'KeePassXCTeam.KeePassXC', 'Microsoft.PowerShell', 'Git.Git', 'twpayne.chezmoi', 'JanDeDobbeleer.OhMyPosh', 'junegunn.fzf', 'lsd-rs.lsd', 'ajeetdsouza.zoxide', 'dalance.procs', 'chmln.sd', 'dbrgn.tealdeer', 'BurntSushi.ripgrep.MSVC', 'dandavison.delta', 'jftuga.less', 'sharkdp.bat', 'sharkdp.fd', 'pnpm.pnpm', 'Clement.bottom', 'ca.duan.tre-command', 'JohnMacFarlane.Pandoc', 'OpenJS.NodeJS', 'Neovim.Neovim', 'UniversalCtags.Ctags', 'sxyazi.yazi', 'charmbracelet.glow', 'PaddiM8.kalker', 'Microsoft.PowerToys', 'Microsoft.VisualStudioCode', '7zip.7zip', 'Dell.DisplayManager', 'Docker.DockerDesktop', 'Anaconda.Anaconda3', 'yt-dlp.yt-dlp', 'martinrotter.RSSGuard', 'OpenWhisperSystems.Signal', 'VideoLAN.VLC', 'Gyan.FFmpeg', 'PeterPawlowski.foobar2000',  'qBittorrent.qBittorrent', 'Soulseek.SoulseekQt', 'Audacity.Audacity', 'dotPDN.PaintDotNet', 'PDFArranger.PDFArranger', 'Joplin.Joplin', 'Zoom.Zoom', 'DigitalScholar.Zotero')) {winget install $app}
foreach ($app in @('PSWindowsUpdate', 'CompletionPredictor', 'PSReadLine -AllowPrerelease', 'PSFzf', 'PowerType -AllowPrerelease')) {Install-Module -Name $app}
foreach ($app in @('ptpython', 'visidata', 'windows-curses', 'epy-reader', 'pynvim', 'urlwatch')) {pip install $app}
foreach ($app in @('hck')) {conda install -c conda-forge $app}
foreach ($app in @('viu')) {cargo install $app}
chezmoi init https://github.com/AvivYaish/dotfiles.git ; chezmoi apply -v
vim -c "call mkdir(stdpath('config'),'p')" -c "call writefile(['set runtimepath^=~/.vim runtimepath+=~/.vim/after', 'let &packpath = &runtimepath', 'source ~/.vimrc'], stdpath('config').'/init.vim', 'a')" +qall

# Some details:
# - I put non-packaged apps in ~\.local\bin, and add the path to PATH.
# - Make sure %PROFILE% points to Microsoft.PowerShell_profile.ps1, and that Windows Terminal's settings.json points to chezmoi's settings.json
# - Set up neovim to use ~/.vimrc using 'vim -c ...' above
# - PSWindowsUpdate: update windows using 'Get-WindowsUpdate ; Install-WindowsUpdate'
# - PSReadLine: nicer PowerShell auto-completion
# - PSFzf: fzf integration with PowerShell
# - PowerType: completion for common commands, may require running 'Set-PSRepository -Name PSGallery -InstallationPolicy Trusted'
# - CompletionPredictor: intellisense for PowerShell
# - visidata: nice terminal spreadsheet tool, requires windows-curses
# - pynvim: required to let neovim use python, for example for the vimspector debugger
# - hck: a 'cut' equivalent
# - viu: a CLI image viewer

# Manual:
# - CLI webpage reader: https://github.com/mrusme/reader
# - OpenConnectGUI: https://gui.openconnect-vpn.net/download/
# - TuxGuitar: https://github.com/helge17/tuxguitar

