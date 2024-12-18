#'###############################################################################
# ABOUT
################################################################################
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# This .bashrc is based on the one I use for my ubuntu work laptop, but
# stripped of sensitive information such as custom server ailases, etc. I have
# organized it into several categories which should make it quicker to find and
# make changes as needed


################################################################################
# SHELL SETTINGS
################################################################################
# files will not be write-able by others by default
umask 002

# If you ssh into a server and this is your .bashrc on it, avoid confusion of
# having previous STDOUT still readable. Delineate clearly between sessions
clear

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend

# spell check
shopt -s cdspell

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1048576
HISTFILESIZE=1048576

# make `less` more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


################################################################################
# GIT
################################################################################
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

GIT_PS1_SHOWDIRTYSTATE=true

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\ $(parse_git_branch) \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\ $(parse_git_branch) \$ '
fi
unset color_prompt force_color_prompt


################################################################################
# ALIASES & FUNCTIONS
################################################################################
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias laa='ls -ld .?*'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# ls aliases
alias l='ls -CF'
alias la='ls -AF'
alias ll='ls -lhF'

# custom aliases
alias update='sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y'
alias untar='tar -xvf'
alias motd='vim ~/.motd'
alias sauce='source ~/.bashrc'
alias ggrep='git grep --color=auto'
alias hgrep='history | grep --color=auto'
alias lo='libreoffice'
alias x='xdg-open'
alias cp='cp -v'
alias checkcam="mpv --profile=low-latency --untimed /dev/video0 --fullscreen"
alias setgamma="xrandr --output `xrandr | grep \" connected\" | head -n1 | cut -f1 -d\" \"` --brightness "
alias mpv="mpv --no-resume-playback"
alias clip='xclip -sel clip'
alias randname="cat /dev/urandom | tr -cd 'a-f0-9' | head -c 32"
alias ghtoken="cat /home/$USER/Documents/TEXT/git.txt | clip"
alias dockerdesktop="systemctl --user enable docker-desktop ; sudo sysctl -w kernel.apparmor_restrict_unprivileged_userns=0 &>/dev/null ; systemctl --user restart docker-desktop"
#alias ghtoken="tail -n1 ~/AUTOSORT/$USER/TXT/git.txt | clip"
alias please='sudo $(history -p !!)'
alias timestamp='date -u +\%FT\%TZ'
# exit aliases
alias sd='shutdown now' # shutdown system

# custom functions
megagrep() {
    # my subpar attempt to parallelize grep
    # splitting on bytes is WAY quicker but jeopardizes recall
    # TODO: test by how much, I can take a 1% loss of recall for 10x SPEED
    if [ $# -ne 2 ]; then
        echo "Usage: megagrep <search_pattern> <filename>"
        return 1
    fi
    local pattern="$1"; local filename="$2"
    if [ ! -f "$2" ]; then
        echo "Error: File '${filename}' not found."
        return 1
    fi
    parallel --pipepart --block 50000k -a "${filename}" -k grep -e "${pattern}"
}


download-album() {
    # USE: simply supply youtube playlist link as $1
    # e.g. user@computer:~/Music\ $ download-album \
    # "https://www.youtube.com/playlist?list=PLI6kLIhBBwmTQ5V6ekRMb-PcXXO8klLSl"
    yt-dlp --sleep-interval 1 --sleep-requests 1 --retry-sleep fragment:300 \
        --ignore-errors --ignore-errors --format bestaudio --extract-audio \
        --output "%(playlist_index)s - %(title)s.%(ext)s" --yes-playlist "$1"
}

mkcd() {
    mkdir -p "$1" && cd "$1"
}

safevim() {
    vim <(cat $1)
}

fvim() {
    vim $(find ./ -name $1)
}

vimgrep-simple() {
    vim +$(grep -ni "${@:1:$#-1}" "${!#}" | head -n1 | cut -d':' -f1) "${!#}"
}

vimgrep() {
    local USAGE="Usage: grep_select <pattern> [file1] [file2] ..."
    local PATTERN="$1"; shift
    local FILES=("$@") # all args after PATTERN are considered
    local STRIP_ANSI="sed 's/\x1B\[[0-9;]*[JKmsu]//g'"

    # arg assertion
    if [[ -z "$PATTERN" ]]; then
        echo "Error: No search pattern provided."
        echo $USAGE
        return 1
    fi
    if [[ ${#FILES[@]} -eq 0 ]]
    then
        echo "Error: No files specified."
        echo $USAGE
        return 1
    fi

    # get matches
    readarray -t MATCHES < \
        <(grep -PHin --color=always "$PATTERN" "${FILES[@]}" 2>/dev/null)
    if [ ${#MATCHES[@]} -eq 0 ]; then
        echo "No matches found for '$PATTERN' in $FILES"
        return 1
    fi

    # menu
    echo -e "\nSelect a line to edit:"
    select SEL in "${MATCHES[@]}"; do
        if [[ -n "$SEL" ]]; then
            EDIT_FILE=$( echo $SEL | eval $STRIP_ANSI | cut -d ':' -f1 )
            LINE_NUM=$(  echo $SEL | eval $STRIP_ANSI | cut -d ':' -f2 )
            vim "$EDIT_FILE" +"$LINE_NUM"
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done
}

bak() {
  for file_path in "$@"; do
    if [ -e "$file_path" ]; then
      cp -v $file_path{,.bak}
    fi
  done
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


################################################################################
# NETWORK
################################################################################
# Connect to Lightcast VPN if not already connected
alias resetwifi="nmcli radio wifi off && nmcli radio wifi on"
alias reconnect="echo 'Resetting wifi connection' && resetwifi && sleep 5 && vpnUp"
alias pi="ssh pi@raspberrypi.local"


################################################################################
# PATHS
################################################################################
export PATH=${PATH}:/bin
export PATH=${PATH}:/home/$USER/.juliaup/bin # manual Julia installation
export PATH=${PATH}:/home/$USER/.local/bin
export PATH=${PATH}:/home/$USER/Bin
export PATH=${PATH}:/home/$USER/bin
export PATH=${PATH}:/opt/bin
export PATH=${PATH}:/opt/ldc2/bin # manual Dlang compiler installation
export PATH=${PATH}:/sbin
export PATH=${PATH}:/snap/bin
export PATH=${PATH}:/usr/bin
export PATH=${PATH}:/usr/local/bin
export PATH=${PATH}:/usr/local/sbin
export PATH=${PATH}:/usr/sbin

# Python
export PYTHONPATH="${PYTHONPATH}:/home/$USER/.local/bin"


################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
# PUT LAUNCH COMMANDS BELOW HERE
################################################################################

## uncomment to immediately enter Tmux when sourcing this file
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux -f ~/.tmux.conf
#fi
cat ~/.motd

################################################################################
# PUT LAUNCH COMMANDS ABOVE HERE
################################################################################
################################################################################
################################################################################
################################################################################
################################################################################
echo  # I like a little space between any .bashrc messages and my prompt
