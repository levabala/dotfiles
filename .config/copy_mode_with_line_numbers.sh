#!/bin/sh

declare -r LINE_NUMBER_PANE_WIDTH=3
declare -r LINE_NUMBER_UPDATE_DELAY=0.1
declare -r COLOR_NUMBERS_RGB="101;112;161"
declare -r COLOR_ACTIVE_NUMBER_RGB="255;158;100"

open_line_number_split(){
    local self_path=$(realpath $0)
    local pane_id=$(tmux display-message -pF "#{pane_id}")

    pgrep -f "$self_path $pane_id" > /dev/null && return

    tmux split-window -h -l $LINE_NUMBER_PANE_WIDTH -b "$self_path $pane_id"
    tmux select-pane -l
}

enter_copy_mode(){
    local target_pane=$1
    tmux copy-mode -t "$target_pane"
}

get_cursor_line(){
    local output=$(tmux display-message -pt "$target_pane" -F '#{copy_cursor_y}')
    echo "${output:-0}"
}

is_in_copy_mode(){
    local mode=$(tmux display-message -p -t "$target_pane" -F '#{pane_mode}')
    ! [ -z $mode ]
}

redraw_line_numbers(){
    local cursor_line=$1
    local lines=$(tput lines)

    clear

    # Print lines above cursor (counting down)
    if [ $cursor_line -gt 0 ]; then
        printf "\e[38;2;$COLOR_NUMBERS_RGB;2m"
        seq $cursor_line -1 1
        printf "\e[0m"
    fi

    # Print current line (highlighted 0)
    printf "\e[38;2;$COLOR_ACTIVE_NUMBER_RGB;1m 0\e[0m"

    # Print lines below cursor
    if [ $lines -gt $(($cursor_line + 1)) ]; then
        local lines_below_count=$(($lines - $cursor_line - 2))
        local last_line_number=$(($lines - $cursor_line - 1))
        
        echo
        printf "\e[38;2;$COLOR_NUMBERS_RGB;2m"
        if [ $lines_below_count -gt 0 ]; then
            seq 1 $lines_below_count
        fi
        printf "$last_line_number"
        printf "\e[0m"
    fi
}

update_loop(){
    local cursor_line=""
    local last_cursor_line="-1"
    
    while is_in_copy_mode; do
        cursor_line=$(get_cursor_line)

        if [ $cursor_line -ne $last_cursor_line ]; then
            redraw_line_numbers $cursor_line
            last_cursor_line=$cursor_line
        fi

        sleep $LINE_NUMBER_UPDATE_DELAY
    done
}

restore_pane_width(){
    local target_pane=$1
    tmux resize-pane -t "$target_pane" -L $(($LINE_NUMBER_PANE_WIDTH + 1))
}

main(){
    local target_pane=$1

    if [ -z $target_pane ]; then
        open_line_number_split
        exit 0
    else
        enter_copy_mode $target_pane
    fi

    update_loop
    restore_pane_width $target_pane
}

main "$@"
