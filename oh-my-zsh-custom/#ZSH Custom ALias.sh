 #ZSH Custom ALias
 
 alias shorthypr="code ~/.config/hypr/modules/binds.conf"
 alias shortdms="code ~/.config/hypr/dms/binds.conf"
 alias zshconfig="code ~/.zshrc"
 alias ohmyzsh="code ~/.oh-my-zsh"
#
# Aliases
alias i="yay -S"
alias r="yay -Rns"
alias u="yay -Syu"
alias s="yay -Ss"
alias q="yay -Q"

alias lsd="lsd -lah"
 alias lstree="lsd -lah --tree"
 alias nvim="lvim"

alias gc="git clone"

# Path
export PATH="/home/$USER/.local/bin:$PATH"
export QT_QPA_PLATFORMTHEME=qt6ct
# Control + Backspace
bindkey '^H' backward-kill-word

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
#alias open="xdg-open"
alias make="make -j`nproc`"
alias ninja="ninja -j`nproc`"
alias n="ninja"
alias c="clear"
alias rmpkg="sudo pacman -Rsn"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias update="sudo pacman -Syu"

# Help people new to Arch
alias apt="man pacman"
alias apt-get="man pacman"
alias please="sudo"
alias tb="nc termbin.com 9999"

# Cleanup orphaned packages
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"

# Get the error messages from journalctl
alias jctl="journalctl -p 3 -xb"

# Recent installed packages
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
