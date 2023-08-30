#!/bin/bash

command="xprop -format _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY "

# hardcoded values due to unexpected behavior when using calculated hex values
declare -A command_map
command_map=(
    ["100%"]="0xFFFFFFFF"
    ["90%"]="0xE6666665"
    ["80%"]="0xCCCCCCCC"
    ["70%"]="0xB3333332"
    ["60%"]="0x99999999"
    ["50%"]="0x7FFFFFFF"
    ["40%"]="0x66666666"
    ["30%"]="0x4CCCCCCC"
    ["20%"]="0x33333333"
    ["10%"]="0x19999999"
)

# values were not presented in order they are given above, sorting necessary
sorted_values=($(for value in "${!command_map[@]}"; do echo "$value"; done | sort -nr))

# prompt user with GUI list of opacity percentages to select from, use selection
# (width/height hardcoded, height might need to be changed if values are
# added/removed to/from the above mapping, could probably calculate width based
# on adding a const for top/bottom parts of box to variable set to length of
# mapping multiplied by height given by each line)
selected_value=$(zenity --list --title="Select opacity..." --column="Values" "${sorted_values[@]}" --height=350 --width=250)

if [ -n "${command_map[$selected_value]}" ]
then
    $command${command_map[$selected_value]}
fi
