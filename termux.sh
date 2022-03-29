#!/bin/zsh

# Termux stuff

# On your computer:
#
# - Install [scrcpy](https://github.com/Genymobile/scrcpy) to control the phone remotely easily.
#   Can do so using scoop: ``scoop install scrcpy``
# - If you use Taskbar and SecondScreen:
#   - Install [adb](https://developer.android.com/studio/command-line/adb)
#     Can do so using scoop: ``scoop install adb``
#   - Enable "Developer Mode" and all the various USB debugging options
#   - Run: ``adb shell pm grant com.farmerbb.secondscreen.free android.permission.WRITE_SECURE_SETTINGS``
#   - Run: ``adb shell pm grant com.farmerbb.taskbar android.permission.WRITE_SECURE_SETTINGS``
#     This allows changing the taskbar's density.
# - Get a DisplayLink adapter if you want to use an external screen and your phone doesn't support MHL.
#   I use [WAVLINK USB3.0 to HDMI Universal Video Graphics Adapter/2048x1152](https://www.amazon.com/dp/B08HN2X88P).
#   It supports audio-out and can be connected to a USB-C hub, and then to a computer.
#   If the hub has an audio-out jack, then if your Android version is too old, you might need to use
#   an app such as [Lesser AudioSwitch](https://play.google.com/store/apps/details?id=com.nordskog.LesserAudioSwitch)
#   to select the correct audio output channel.

# On your phone:
#
# - Install [Taskbar](https://play.google.com/store/apps/details?id=com.farmerbb.taskbar).
#   This is a nice desktop-like launcher.
# - Install [SecondScreen](https://play.google.com/store/apps/details?id=com.farmerbb.secondscreen.free)
#   This allows you to set the resolution and density for your large screen.
# - Install [F-Droid](https://f-droid.org), a nice app store.
# - Install termux using F-Droid
# - Install some programs:
if [ ! -d ${local_bin} ]; then
  mkdir -p ${local_bin}
fi

# - libzmq is needed for some python packages that fail to use 'pip' to install 'pyzmq'
for app in wget neovim zsh git chezmoi zoxide curlie bat lsd git-delta ripgrep sd ctags tealdeer nodejs fd byobu fzf lf procs bottom glow openjdk-17 libzmq; do
  pkg install ${app}
done

# Set up zsh
chsh -s zsh
if ! test -f ${local_bin}/antigen.zsh; then
  curl -L git.io/antigen > ${local_bin}/antigen.zsh
fi

# - Fetch my dotfiles:
chezmoi init https://github.com/AvivYaish/dotfiles.git
chezmoi update -v

# - Hide extra keys
echo "" >> ~/.termux/termux.properties
echo "extra-keys = []" >> ~/.termux/termux.properties

# - Install the Nerd Font "Fira Code Regular Nerd Font Complete":
curl -fL "https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/FiraCode/Regular/complete/Fira%20Code%20Regular%20Nerd%20Font%20Complete.ttf" > ~/.termux/font.ttf

# - Install XFCE following [this](https://wiki.termux.com/wiki/Graphical_Environment)
pkg install x11-repo
pkg install tigervnc
pkg install xfce4
pkg install xfce4-terminal
pkg install otter-browser

# - Configure TigerVNC:
echo "" > ~/.vnc/xstartup
cat <<EOT >> ~/.vnc/xstartup
#!/data/data/com.termux/files/usr/bin/sh
xfce4-session &
EOT

echo "" > ~/.vnc/config
cat <<EOT >> ~/.vnc/config
# Supported server options to pass to vncserver upon invocation can be listed
# in this file. See the following manpages for more: vncserver(1) Xvnc(1).
# Several common ones are shown below. Uncomment and modify to your liking.
geometry=3840x2160 # Define the resolution
EOT

# - Create a run script in .local/bin/startdesktop
echo "" > ~/.local/bin/startdesktop
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

# - After running the script, the relevant port is 5901
# - Can connect from phone using [VNC Viewer](https://play.google.com/store/apps/details?id=com.realvnc.viewer.android), IP is 127.0.0.1
# - Can connect from a computer using TigerVNC, check IP using ifconfig
# - After starting XFCE:
#   - Install Orchis-dark-compact theme:
git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
./install.sh
#   - Change theme both in "Appearance" and "Window Manager"
#   - Install Papirus-Dark:
wget -qO- https://git.io/papirus-icon-theme-install | sh
#   - Install [Oreo Blue cursors](https://github.com/varlesh/oreo-cursors).
#   - Create [onedark.theme](https://gist.github.com/fluxrad/f9ff8bf36c3f58e63265c34f2751ff18) in ~/../usr/share/xfce4/terminal/colorschemes/
#   - Unlock bottom panel, move to the left.
