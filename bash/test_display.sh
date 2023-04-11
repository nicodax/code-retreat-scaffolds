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
test_init_display_grid_with_vertical_spinner() {
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

# LOAD SHUNIT2
. shunit2