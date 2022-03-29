#!/bin/bash

for app in git wget chezmoi zoxide curlie bat lsd git-delta ripgrep sd ctags tealdeer fd byobu fzf lf procs bottom glow openjdk-17; do
  pkg install ${app}
done

chezmoi init https://github.com/AvivYaish/dotfiles.git
chezmoi update -v

pkg install x11-repo
pkg install tigervnc
pkg install xfce4
pkg install xfce4-terminal
pkg install otter-browser

p10k configure

echo "" >! ~/.vnc/xstartup
cat <<EOT >> ~/.vnc/xstartup
#!/data/data/com.termux/files/usr/bin/sh
xfce4-session &
EOT

echo "" >! ~/.vnc/config
cat <<EOT >> ~/.vnc/config
# Supported server options to pass to vncserver upon invocation can be listed
# in this file. See the following manpages for more: vncserver(1) Xvnc(1).
# Several common ones are shown below. Uncomment and modify to your liking.
geometry=3840x2160 # Define the resolution
EOT

echo "" >! ~/.local/bin/startdesktop
cat <<EOT >> ~/.local/bin/startdesktop
#!/data/data/com.termux/files/usr/bin/bash
# Export Display
export DISPLAY=":1"
# Start VNC Server
while [[ $(pidof Xvnc) ]]; do
  echo -e "\n[!] Server Already Running."
  { vncserver -list; echo; }
  read -p "Kill VNC Server? (Y/N) : "
  if [[ "$REPLY" == "Y" || "$REPLY" == "y" ]]; then
    { killall Xvnc; echo; }
  else
    echo
  fi
done
echo -e "\n[*] Starting VNC Server..."
vncserver  # add -localhost if you don't want to connect remotely
EOT

git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
./install.sh

wget -qO- https://git.io/papirus-icon-theme-install | sh

# # Termux stuff
# 
# - Installed termux using F-Droid
# - Installed [scrcpy](https://github.com/Genymobile/scrcpy) on my PC to control
#   the phone remotely.
# - Installed some programs:
# 
#   ```Shell
#   for app in git wget chezmoi zoxide curlie bat lsd git-delta ripgrep sd ctags tealdeer fd byobu fzf lf procs bottom glow openjdk-17; do
#     pkg install ${app}
#   done
#   ```
# 
# - Fetched my dotfiles:
# 
#   ```Shell
#   chezmoi init https://github.com/AvivYaish/dotfiles.git
#   chezmoi update -v
#   ```
# 
# - Installed XFCE following [this](https://wiki.termux.com/wiki/Graphical_Environment)
# 
#   ```Shell
#   pkg install x11-repo
#   pkg install tigervnc
#   pkg install xfce4
#   pkg install xfce4-terminal
#   pkg install otter-browser
#   ```
# 
# - Configure TigerVNC:
#   - In ~/.vnc/xstartup:
# 
#   ```Shell
#   #!/data/data/com.termux/files/usr/bin/sh
#   xfce4-session &
#   ```
# 
#   - In ~/.vnc/config:
# 
#   ```Shell
#   # Supported server options to pass to vncserver upon invocation can be listed
#   # in this file. See the following manpages for more: vncserver(1) Xvnc(1).
#   # Several common ones are shown below. Uncomment and modify to your liking.
#   geometry=3840x2160 # Define the resolution
#   ```
# 
# - Create a run script in .local/bin/startdesktop
# 
#   ```Shell
#   #!/data/data/com.termux/files/usr/bin/bash
#   # Export Display
#   export DISPLAY=":1"
#   # Start VNC Server
#   while [[ $(pidof Xvnc) ]]; do
#     echo -e "\n[!] Server Already Running."
#     { vncserver -list; echo; }
#     read -p "Kill VNC Server? (Y/N) : "
#     if [[ "$REPLY" == "Y" || "$REPLY" == "y" ]]; then
#       { killall Xvnc; echo; }
#     else
#       echo
#     fi
#   done
#   echo -e "\n[*] Starting VNC Server..."
#   vncserver  # add -localhost if you don't want to connect remotely
#   ```
# 
# - After running the script, the relevant port is 5901
# - Can connect from phone using [VNC Viewer](https://play.google.com/store/apps/details?id=com.realvnc.viewer.android), IP is 127.0.0.1
# - Can connect from a computer using TigerVNC, check IP using ifconfig
# - After starting XFCE:
#   - Install the Nerd Font "MesloLGMNF":
# 
#   ```Shell
#   p10k configure
#   ```
# 
#   - Install Orchis-dark-compact theme:
# 
#   ```Shell
#   git clone https://github.com/vinceliuice/Orchis-theme.git
#   cd Orchis-theme
#   ./install.sh
#   ```
# 
#   - Change theme both in "Appearance" and "Window Manager"
# 
#   - Install Papirus-Dark:
# 
#   ```Shell
#   wget -qO- https://git.io/papirus-icon-theme-install | sh
#   ```
# 
#   - Install [Oreo Blue cursors](https://github.com/varlesh/oreo-cursors).
#   - Create [onedark.theme](https://gist.github.com/fluxrad/f9ff8bf36c3f58e63265c34f2751ff18) in ~/../usr/share/xfce4/terminal/colorschemes/
#   - Unlock bottom panel, move to the left.
