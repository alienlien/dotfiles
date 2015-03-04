# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias rm='rm -i'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lt='ll -t -r -h'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Alias for the newer ctags installed through homebrew
alias ctags="`brew --prefix`/bin/ctags"

# Alias for CSI
alias xmdev='ssh -i ~/.ssh/google_compute_engine csiuser@107.167.186.37'
alias xmdev2='ssh -i ~/.ssh/google_compute_engine csiuser@107.167.184.173'
alias csilist='gcloud compute instances list'
alias csilog1='gcloud compute ssh --zone us-central1-a --project studio-csi-sta csiuser@ccloud-sta-helper-us-central1-a-logcollector-txvl'
alias csilog2='gcloud compute ssh --zone us-central1-a --project studio-csi-sta csiuser@ccloud-sta-helper-us-central1-a-logcollector-z0wb'
alias csilog3='gcloud compute ssh --zone us-central1-a --project studio-csi-sta csiuser@ccloud-sta-helper-us-central1-a-logcollector-m562'
alias csiman='gcloud compute ssh --zone us-central1-f --project studio-csi-prod csiuser@ccloud-prod-us-central1-f-cl-is-a-real-man'
alias csidev='gcloud compute ssh --zone us-central1-a --project studio-csi-dev csiuser@ccloud-roy-tester-standard-2-new-permission'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Add Path for Java
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=$PATH:$JAVA_HOME/bin

# Add Path for Golang
export GOROOT=$HOME/workspace/local/go
export PATH=$PATH:$GOROOT/bin
# Fix when GOPATH has multiple items
export GOPATH=$HOME/workspace/project/csi
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$HOME/workspace/project/csi/src/htc.com/csi/vendor/bin

# Add Path for Golint
export GOLINT=$HOME/workspace/project/csi/src/github.com/golang/lint/golint
export PATH=$PATH:$GOLINT

# Add Path for HBase
export HBASE=$HOME/workspace/local/hbase-0.98.8-hadoop2
export PATH=$PATH:$HBASE/bin

# Add Path for Arc
export ARCANIST=$HOME/workspace/local/arcanist/arcanist
export PATH=$PATH:$ARCANIST/bin

# Add Path for Zookeeper
export ZK_HOME=$HOME/workspace/local/zookeeper-3.4.6
export PATH=$PATH:$ZK_HOME/bin

## Add Path for cscope database
#export CSCOPE_DB=$HOME/workspace/local/cscope_db

# Commands for csi project on gcloud
# determine project by hostname
function csi_project {
base_cmd='gcloud compute ssh'
hostname=$1
zone="us-central1-f"
if echo $hostname | grep 'us-central1-a'
then zone="us-central1-a"
fi
shift;
  if echo $hostname | grep 'prod-'
  then $base_cmd --project="studio-csi-prod" $hostname --zone=$zone
  elif echo $hostname | grep 'sta-'
  then $base_cmd --project="studio-csi-sta" $hostname --zone=$zone
  else
     $base_cmd --project="studio-csi-dev" $hostname --zone=$zone
  fi
}
alias gssh=csi_project

# Import the environment for csi project.
source $GOPATH/src/htc.com/csi/env.sh

# Add the branch name for git repo. 
function parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
 
RED="\[\033[0;31m\]"
YELLOW="\[\033[0;33m\]"
GREEN="\[\033[0;32m\]"
NO_COLOR="\[\033[0m\]"
 
PS1="$NO_COLOR\u@\h$NO_COLOR:\w$YELLOW\$(parse_git_branch)$NO_COLOR\$ "

# Add auto complete for git command
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Add supports for nail
export NATS_CLUSTER=nats://23.236.50.152:4222/

# Environment setting for docker
export DOCKER_HOST=tcp://192.168.59.103:2376
export DOCKER_CERT_PATH=/Users/Alien_Lien/.boot2docker/certs/boot2docker-vm
export DOCKER_TLS_VERIFY=1

# The next line updates PATH for the Google Cloud SDK.
source '/Users/Alien_Lien/google-cloud-sdk/path.bash.inc'

# The next line enables bash completion for gcloud.
source '/Users/Alien_Lien/google-cloud-sdk/completion.bash.inc'
