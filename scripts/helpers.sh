#!/usr/bin/env bash

get_tmux_option() {
  local option default_value option_value 
  option="$1"
  default_value="$2"
  option_value="$(tmux show-option -gqv "$option")"

  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}
