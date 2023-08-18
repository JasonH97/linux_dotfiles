# This is the .bashrc for my ubuntu work laptop. much of it is the default but
# it does contain some super useful bits, particularly the ability to show
# current git branch if the current dir is a git repo

# TODO: refactor to be truly my own, instead of my changes to ubuntu defaults

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=
HISTFILESIZE=

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
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

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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
alias ggrep='git grep --color=auto'
alias hgrep='history | grep --color=auto'
alias lo='libreoffice'
alias x='xdg-open'
#alias update='sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y' # commented out after this command downgraded my kernel to one with a critical vulnerability after I recently manually upgraded it
alias vim='nvim-apt' # I have installed and configured neovim to replace vim
alias cp='cp -v'
alias clip='xclip -sel clip'

# create timestamp
alias timestamp='echo -n "lastModified: " && date -u +\%FT\%TZ'

# custom functions
function lovim {
    vim "$(locate "$1" | grep -Pv '\.swp$' | head -n1)"
}

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# spell check
shopt -s cdspell

# servers
alias pi="ssh pi@raspberrypi.local"

# python path
export PYTHONPATH="${PYTHONPATH}:/home/$USER/.local/bin"

# PATH
export PATH=/home/$USER/.local/bin:/home/$USER/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/snap/bin:/home/$USER/bin:/home/$USER/bin/kotlinc/bin:/home/$USER/Android/android-studio/bin:/home/$USER/.cargo/bin

# put launch commands here

#cat ~/personal-not-work-related/antiochian/motd.txt
echo ================================================================================
hostnamectl
cat ~/AUTOSORT/$USER/TXT/todo.txt


## open tmux when not in tmux
#if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#  exec tmux -f ~/.tmux.conf
#fi
alias ghtoken="tail -n1 ~/AUTOSORT/$USER/TXT/git.txt | clip"
echo "<ctrl><shift><u>0394 = Δ"
#. "$HOME/.cargo/env"
echo 
