### ===== FAST BOOT GUARDS (must be first) =====
# Disable oh-my-zsh update checks (they add 1–2s sometimes)
export DISABLE_AUTO_UPDATE="true"
export DISABLE_UPDATE_PROMPT="true"
export DISABLE_MAGIC_FUNCTIONS="false"
# Completion: we control compinit, not OMZ
export ZSH_DISABLE_COMPFIX=true
typeset -g skip_global_compinit=1

# Stable compdump location
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${ZSH_COMPDUMP:h}"

# --- zsh-autocomplete FIRST ---
#source /usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
#autoload -Uz compinit
#compinit -C -d "$ZSH_COMPDUMP"

### ===========================================

fastfetch 
#countryfetch unitedstates
# If you come from bash you might have to change your $PATH.
export PATH="$HOME/.cargo/bin:$PATH"
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# Path to your Oh My Zsh installation.
source ~/.secrets 2>/dev/null
export MUSIC_DIR="$HOME/Music"
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="imp"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
#( pygmalion tjkirch_mod"robbyrussell" "agnoster" "daivasmara" "windows" "classytouch" "powerlevel10k/powerlevel10k" "ohwonder" "imp" "bender")
#BENDER_THEME_STYLE=mini
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
export HISTCONTROL=ignoreboth
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Don't add certain commands to the history file.
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${ZSH_COMPDUMP:h}"

export HISTORY_IGNORE="(\&|[bf]g|c|clear|history|exit|q|pwd|* --help)"
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Use custom `less` colors for `man` pages.
export LESS_TERMCAP_md="$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)"
export LESS_TERMCAP_me="$(tput sgr0 2> /dev/null)"

 HYPHEN_INSENSITIVE="true"
# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
 zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time
# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13
# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

eval "$(zoxide init zsh --cmd z)"
alias zi="z -i"   # interactive

 ENABLE_CORRECTION="true"
 DISABLE_UNTRACKED_FILES_DIRTY="true"

 HIST_STAMPS="mm/dd/yyyy"
setopt inc_append_history share_history hist_ignore_all_dups hist_save_no_dups

# --- then oh-my-zsh ---
export ZSH="$HOME/.oh-my-zsh"
plugins=(git)

 export MANPATH="/usr/local/man:$MANPATH"
# You may need to manually set your language environment
 export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
 if [[ -n $SSH_CONNECTION ]]; then
   export EDITOR='code'
 else
   export EDITOR='nvim'
# Prevent OMZ from running compinit again (we already did it)
 fi
zstyle ':omz:lib:compfix' enabled no
typeset -g skip_global_compinit=1
# Make OMZ's compinit fast and use our dump location
export ZSH_COMPDUMP="${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${ZSH_COMPDUMP:h}"

export FZF_BASE=/usr/share/fzf
# Speed knobs for completion
export ZSH_DISABLE_COMPFIX=true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "${XDG_CACHE_HOME:-$HOME/.cache}/zsh/zcompcache"

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
source $ZSH/oh-my-zsh.sh

alias musicdash="tmux new-session \; source-file ~/.config/ncmpcpp/tmux-music.conf"
alias make="make -j`nproc`"
alias ninja="ninja -j`nproc`"
alias n="ninja"
alias c="clear"
alias cleanch="sudo pacman -Scc"
alias fixpacman="sudo rm /var/lib/pacman/db.lck"
alias cleanup="sudo pacman -Rsn $(pacman -Qtdq)"
alias jctl="journalctl -p 3 -xb"
alias ai="$HOME/.local/bin/sys-agent"
alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
alias hyprb="code ~/.config/hypr/modules/binds.conf"
alias dmsb="code ~/.config/hypr/dms/binds.conf"
alias zshconf="code ~/.zshrc"
alias ohmyzsh="code ~/.oh-my-zsh"
alias i="yay -S"
alias r="yay -Rns"
alias u="yay -Syu"
alias s="yay -Ss"
alias q="yay -Q"
alias l="lsd -lah"
alias lstree="lsd -lah --tree"

alias gc="git clone"
bindkey '^H' backward-kill-word
# Path
export PATH="/home/$USER/.local/bin:$PATH"
export QT_QPA_PLATFORMTHEME=qt6ct
# Control + Backspace
source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Use history substring search
# Normal arrows
bindkey '^[[A' up-line-or-history
bindkey '^[[1;5B' down-line-or-history

# Substring search on Ctrl+Up / Ctrl+Down
bindkey '^[[1;5A' history-substring-search-up
bindkey '^[[1;5B' history-substring-search-down


# pkgfile "command not found" handler
source /usr/share/doc/pkgfile/command-not-found.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.

export JAVA_HOME=/opt/jgrasp/bundled/java
export PATH=$JAVA_HOME/bin:$PATH
# Generated for envman. Do not edit.
