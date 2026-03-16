# Auto-start Hyprland only on TTY1
#if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
#    exec Hyprland
#fi
if uwsm check may-start && uwsm select; then
	exec uwsm start default
fi
# GNOME keyring
#eval $(gnome-keyring-daemon --start)

# SSH stuff
#export SSH_AUTH_SOCK


export PATH="$HOME/.local/bin:$PATH"

