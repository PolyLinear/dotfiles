#!/bin/bash

dir="$HOME"
workspace_name="$1"

[[ -d $2 ]] && dir="$2"

#shellcheck disable=SC2046
read -r -a data <<<$(tmux ls | cut -d : -f 1)

function create_workspace() {

	tmux new -s "$workspace_name" -y 54 -d
	tmux send-keys -t 0 "cd "$dir"" C-m
	tmux send-keys -t 0 "nvim" C-m
	tmux split-window -v
	tmux send-keys -t 1 "cd "$dir"" C-m
	tmux send-keys -t 1 "clear" C-m
	tmux resize-pane -D 15
	tmux attach-session -t "$workspace_name"

}

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
			break
		fi

	done
fi
create_workspace
