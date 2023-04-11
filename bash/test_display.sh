#!/bin/bash
. display.sh

# IT SHOULD CREATE A 3x3 GRID WITH A VERTICAL SPINNER
test_init_display_grid_with_vertical_spinner() {
    init_display_grid_with_vertical_spinner
    expected=(0 1 0 0 1 0 0 1 0)
    assertEquals 3 $DISPLAY_GRID_WIDTH
    assertEquals "${expected[*]}" "${DISPLAY_GRID[*]}"

    assertEquals 3 "${#LIVE_CELLS[@]}"
    assertEquals 1 "${LIVE_CELLS["1_0"]}"
    assertEquals 1 "${LIVE_CELLS["1_1"]}"
    assertEquals 1 "${LIVE_CELLS["1_2"]}"
}

# IT SHOULD CREATE A 3x3 GRID WITH A HORIZONTAL SPINNER
test_init_display_grid_with_horizontal_spinner() {
    init_display_grid_with_horizontal_spinner
    expected=(0 0 0 1 1 1 0 0 0)
    assertEquals 3 $DISPLAY_GRID_WIDTH
    assertEquals "${expected[*]}" "${DISPLAY_GRID[*]}"

    assertEquals 3 "${#LIVE_CELLS[@]}"
    assertEquals 1 "${LIVE_CELLS["0_1"]}"
    assertEquals 1 "${LIVE_CELLS["1_1"]}"
    assertEquals 1 "${LIVE_CELLS["2_1"]}"
}

# IT SHOULD PRINT THE GRID BORDER DEPENDING ON THE GRID SIZE
test_print_border() {
    DISPLAY_GRID_WIDTH=4

    tmpfile=$(mktemp /tmp/test_print_border.XXXXXX)
    print_border > "$tmpfile"

    expected="* --- * --- * --- * --- *"
    actual=$(cat "$tmpfile")
    assertEquals "$expected" "$actual"

    rm "$tmpfile"
}

# IT SHOULD PRINT THE REQUESTED ROW
test_print_row() {
    init_display_grid_with_horizontal_spinner

    tmpfile=$(mktemp /tmp/test_print_row.XXXXXX)

    # FIRST ROW
    print_row 0 > "$tmpfile"
    expected="|  0  |  0  |  0  |"
    actual=$(cat "$tmpfile")
    assertEquals "$expected" "$actual"

    # SECOND ROW
    print_row 1 > "$tmpfile"
    expected="|  1  |  1  |  1  |"
    actual=$(cat "$tmpfile")
    assertEquals "$expected" "$actual"

    # THIRD (LAST) ROW
    print_row 2 > "$tmpfile"
    expected="|  0  |  0  |  0  |"
    actual=$(cat "$tmpfile")
    assertEquals "$expected" "$actual"

    rm "$tmpfile"
}

# IT SHOULD RETURN GIVEN CELL NEIGHBORS
test_get_neighbors_of() {
    init_display_grid_with_vertical_spinner

    # CELL (0, 0)
    expected_neighbors_00=("-1_-1" "0_-1" "1_-1" "-1_0" "1_0" "-1_1" "0_1" "1_1")
    neighbors_00=($(get_neighbors_of 0 0))
    assertEquals 8 "${#neighbors_00[@]}"
    assertEquals "${expected_neighbors_00[*]}" "${neighbors_00[*]}"

    # CELL (1, 0)
    expected_neighbors_10=("0_-1" "1_-1" "2_-1" "0_0" "2_0" "0_1" "1_1" "2_1")
    neighbors_10=($(get_neighbors_of 1 0))
    assertEquals 8 "${#neighbors_10[@]}"
    assertEquals "${expected_neighbors_10[*]}" "${neighbors_10[*]}"

    # CELL (1, 1)
    expected_neighbors_11=("0_0" "1_0" "2_0" "0_1" "2_1" "0_2" "1_2" "2_2")
    neighbors_11=($(get_neighbors_of 1 1))
    assertEquals 8 "${#neighbors_11[@]}"
    assertEquals "${expected_neighbors_11[*]}" "${neighbors_11[*]}"
}

# IT SHOULD RETURN THE NUMBER OF ALIVE NEIGHBORS FOR GIVEN CELL
test_get_live_neighbor_count_of() {
    init_display_grid_with_vertical_spinner

    # CELL (0, 0)
    assertEquals 2 $(get_live_neighbor_count_of 0 0)

    # CELL (1, 0)
    assertEquals 1 $(get_live_neighbor_count_of 1 0)

    # CELL (0, 1)
    assertEquals 3 $(get_live_neighbor_count_of 0 1)

    # CELL (1, 1)
    assertEquals 2 $(get_live_neighbor_count_of 1 1)
}

# IT SHOULD RETURN THE NEXT STATE OF GIVEN CELL
test_get_next_state_of() {
    init_display_grid_with_vertical_spinner

    # CELL (0, 0)
    assertEquals 0 $(get_next_state_of 0 0)

    # CELL (1, 0)
    assertEquals 0 $(get_next_state_of 1 0)

    # CELL (0, 1)
    assertEquals 1 $(get_next_state_of 0 1)

    # CELL (1, 1)
    assertEquals 1 $(get_next_state_of 1 1)
}

# IT SHOULD RETURN THE NEXT GEN LIVE CELLS
test_next_gen_infinite_grid() {
    init_display_grid_with_vertical_spinner
    next_gen_infinite_grid

    expected=(0 0 0 1 1 1 0 0 0)
    assertEquals "${expected[*]}" "${DISPLAY_GRID[*]}"

    assertEquals 3 "${#LIVE_CELLS[@]}"
    assertEquals 1 "${LIVE_CELLS["0_1"]}"
    assertEquals 1 "${LIVE_CELLS["1_1"]}"
    assertEquals 1 "${LIVE_CELLS["2_1"]}"
}

# IT SHOULD RETURN THE LIST OF CELLS TO CHECK
test_get_cells_to_check() {
    init_display_grid_with_vertical_spinner
    get_cells_to_check

    assertEquals 15 "${#CELLS_TO_CHECK[@]}"
    assertEquals 1 "${CELLS_TO_CHECK["1_0"]}"
    assertEquals 1 "${CELLS_TO_CHECK["1_1"]}"
    assertEquals 1 "${CELLS_TO_CHECK["1_2"]}"
    assertEquals 1 "${CELLS_TO_CHECK["0_-1"]}"
    assertEquals 1 "${CELLS_TO_CHECK["1_-1"]}"
    assertEquals 1 "${CELLS_TO_CHECK["2_-1"]}"
    assertEquals 1 "${CELLS_TO_CHECK["0_0"]}"
    assertEquals 1 "${CELLS_TO_CHECK["2_0"]}"
    assertEquals 1 "${CELLS_TO_CHECK["0_1"]}"
    assertEquals 1 "${CELLS_TO_CHECK["2_1"]}"
    assertEquals 1 "${CELLS_TO_CHECK["0_2"]}"
    assertEquals 1 "${CELLS_TO_CHECK["2_2"]}"
    assertEquals 1 "${CELLS_TO_CHECK["0_3"]}"
    assertEquals 1 "${CELLS_TO_CHECK["1_3"]}"
    assertEquals 1 "${CELLS_TO_CHECK["2_3"]}"
}

# LOAD SHUNIT2
. shunit2