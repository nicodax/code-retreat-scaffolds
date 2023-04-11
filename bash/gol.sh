#!/bin/bash
if [[ $1 == run ]]; then
    source display.sh
    # EITHER:
    #   * initialize grid with custom values
    #   * use the init_display_grid_with_vertical_spinner function
    #   * use the init_display_grid_with_horizontal_spinner function
    #
    # DISPLAY_GRID=("${INIT[@]}")
    init_display_grid_with_vertical_spinner
    # init_display_grid_with_horizontal_spinner
    while true; do
        clear
        print_border
        for (( r=0 ; r<$DISPLAY_GRID_WIDTH ; r++ )); do
        print_row "$r"
        print_border
        done
        next_gen
        sleep 2
    done
elif [[ $1 == test ]]; then
    bash test_display.sh
else
    echo "please use a valid argument when calling the script."
    echo "currently, you can call this script like the following:"
    echo "* bash gol.sh run to run the game of life"
    echo "* bash gol.sh test to run the tests"
fi