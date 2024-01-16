#!/bin/bash

dir="$HOME"
workspace_name="$2"

[[ -d $1 ]] && dir="$1"

#shellcheck disable=SC2046
read -r -a data <<<$(tmux ls | cut -d : -f 1)

if [ -n "$workspace_name" ]; then
	while :; do
		no_repeats=true
		for val in "${data[@]}"; do
			if [ "$val" = "$workspace_name" ]; then
				echo "duplicate name detected, please enter something else"
				read -rp "New Workspace Name: " workspace_name
				no_repeats=false
			fi
		done
		if $no_repeats; then
			tmux new -s "$workspace_name" -d
			tmux send-keys -t 0 "cd "$dir"" C-m
			tmux send-keys -t 1 "cd "$dir"" C-m
			tmux split-window -v
			tmux resize-pane -D 25
			tmux attach-session -t "$workspace_name"
			break
		fi

	done
fi
