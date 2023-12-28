#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
export OBSIDIAN_USE_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias wpwd='wl-copy $(pwd)'
alias wcp='cd $(wl-paste)'
alias gd='github-desktop --enable-features=UseOzonePlatform --ozone-platform=wayland'
alias disk='xxd -b -l 128'
PATH=$PATH:$HOME/scripts
PS1='[\u@\h \W]\$ '

