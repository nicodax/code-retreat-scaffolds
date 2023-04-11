#!/bin/bash
. display.sh

# IT SHOULD CREATE A 3x3 GRID WITH A VERTICAL SPINNER
test_init_display_grid_with_vertical_spinner() {
    init_display_grid_with_vertical_spinner
    expected=(0 1 0 0 1 0 0 1 0)
    assertEquals 3 $DISPLAY_GRID_WIDTH
    assertEquals "${expected[*]}" "${DISPLAY_GRID[*]}"
}

# IT SHOULD CREATE A 3x3 GRID WITH A HORIZONTAL SPINNER
test_init_display_grid_with_horizontal_spinner() {
    init_display_grid_with_horizontal_spinner
    expected=(0 0 0 1 1 1 0 0 0)
    assertEquals 3 $DISPLAY_GRID_WIDTH
    assertEquals "${expected[*]}" "${DISPLAY_GRID[*]}"
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

test_get_neighbors_of() {
    init_display_grid_with_vertical_spinner

    # CELL (0, 0)
    expected_neighbours_00=(1 0 1)
    actual_neighbours_00=$(get_neighbors_of 0 0)
    assertEquals "${expected_neighbours_00[*]}" "${actual_neighbours_00[*]}"

    # CELL (1, 0)
    expected_neighbours_10=(0 0 0 1 0)
    actual_neighbours_10=$(get_neighbors_of 1 0)
    assertEquals "${expected_neighbours_10[*]}" "${actual_neighbours_10[*]}"

    # CELL (1, 1)
    expected_neighbours_11=(0 1 0 0 0 0 1 0)
    actual_neighbours_11=$(get_neighbors_of 1 1)
    assertEquals "${expected_neighbours_11[*]}" "${actual_neighbours_11[*]}"
}

test_get_live_neighbor_count_from() {
    init_display_grid_with_vertical_spinner

    # CELL (0, 0)
    neighbours_00=($(get_neighbors_of 0 0))
    expected_live_neighbours_00=2
    actual_live_neighbours_00=$(get_live_neighbor_count_from "${neighbours_00[@]}")
    assertEquals $expected_live_neighbours_00 $actual_live_neighbours_00

    # CELL (1, 0)
    neighbours_10=($(get_neighbors_of 1 0))
    expected_live_neighbours_10=1
    actual_live_neighbours_10=$(get_live_neighbor_count_from "${neighbours_10[@]}")
    assertEquals $expected_live_neighbours_10 $actual_live_neighbours_10

    # CELL (0, 1)
    neighbours_01=($(get_neighbors_of 0 1))
    expected_live_neighbours_01=3
    actual_live_neighbours_01=$(get_live_neighbor_count_from "${neighbours_01[@]}")
    assertEquals $expected_live_neighbours_01 $actual_live_neighbours_01

    # CELL (1, 1)
    neighbours_11=($(get_neighbors_of 1 1))
    expected_live_neighbours_11=2
    actual_live_neighbours_11=$(get_live_neighbor_count_from "${neighbours_11[@]}")
    assertEquals $expected_live_neighbours_11 $actual_live_neighbours_11
}

test_get_next_state_of() {
    init_display_grid_with_vertical_spinner

    # CELL (0, 0)
    expected_next_state_00=0
    actual_next_state_00=$(get_next_state_of 0 0)
    assertEquals $expected_next_state_00 $actual_next_state_00

    # CELL (0, 1)
    expected_next_state_01=1
    actual_next_state_01=$(get_next_state_of 0 1)
    assertEquals $expected_next_state_01 $actual_next_state_01

    # CELL (1, 0)
    expected_next_state_10=0
    actual_next_state_10=$(get_next_state_of 1 0)
    assertEquals $expected_next_state_10 $actual_next_state_10

    # CELL (1, 1)
    expected_next_state_11=1
    actual_next_state_11=$(get_next_state_of 1 1)
    assertEquals $expected_next_state_11 $actual_next_state_11
}

test_next_gen() {
    init_display_grid_with_horizontal_spinner
    expected_next_gen=(0 1 0 0 1 0 0 1 0)

    next_gen

    assertEquals "${expected_next_gen[*]}" "${DISPLAY_GRID[*]}"
}

# LOAD SHUNIT2
. shunit2