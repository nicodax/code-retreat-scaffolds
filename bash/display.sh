#!/bin/bash
GRID_WIDTH=3
INIT=(0 0 0 1 1 1 0 0 0)
GRID=()

function init_grid_with_vertical_spinner() {
  GRID_WIDTH=3
  GRID=(0 1 0 0 1 0 0 1 0)
}

function init_grid_with_horizontal_spinner() {
  GRID_WIDTH=3
  GRID=(0 0 0 1 1 1 0 0 0)
}

function print_border {
  printf "%s\n" "$(printf '* --- %.0s' $(seq 1 $GRID_WIDTH))""*"
}

function print_row {
  local row_start_idx=$(( $1 * $GRID_WIDTH ))
  for (( i=0 ; i<$GRID_WIDTH ; i++ )); do
    local cell_idx=$(( $row_start_idx + $i ))
    printf "|  %s  " "${GRID[$cell_idx]}"
  done
  printf "|\n"
}

function next_gen {
  # TO DO
  local new_grid=("${GRID[@]}")
  GRID=("${new_grid[@]}")
}
