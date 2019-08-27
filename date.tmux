#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

source "$CURRENT_DIR/scripts/helpers.sh"

date_interpolation=(
	"\#{date_utc}"
	"\#{date_local}"
)

date_commands=(
	"#($CURRENT_DIR/scripts/date.sh -u '+%H:%M %Z')"
	"#($CURRENT_DIR/scripts/date.sh '+%H:%M %Z')"
)

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

do_interpolation() {
	local all_interpolated="$1"
	for ((i=0; i<${#date_commands[@]}; i++)); do
		all_interpolated=${all_interpolated//${date_interpolation[$i]}/${date_commands[$i]}}
	done
	echo "$all_interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
}

main() {
	update_tmux_option "status-right"
	update_tmux_option "status-left"
}
main





# vim: ft=sh
