#
# ~/.bash_profile
#

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_RUNTIME_DIR=/run/user/`id -u`
export LESSHISTFILE=-

[[ -f ~/.bashrc ]] && . ~/.bashrc

