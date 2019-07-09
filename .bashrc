# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
export LS_OPTIONS='--color=auto'
eval "`dircolors`"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -lA'
alias cpwd='pwd|pbcopy'

#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'
. /opt/conda/etc/profile.d/conda.sh
conda activate base
LD_LIBRARY_PATH=/usr/lib64-nvidia
export LD_LIBRARY_PATH
export LC_ALL=C.UTF-8
export LC_ALL=C.UTF-8
export LANG=C.UTF-8