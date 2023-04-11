#!/bin/bash
DISPLAY_GRID_WIDTH=3
INIT=(0 0 0 1 1 1 0 0 0)
DISPLAY_GRID=()
INFINITE_GRID=1

function init_display_grid_with_vertical_spinner {
  GRID_WIDTH=3
  DISPLAY_GRID=(0 1 0 0 1 0 0 1 0)
}

function init_display_grid_with_horizontal_spinner {
  DISPLAY_GRID_WIDTH=3
  DISPLAY_GRID=(0 0 0 1 1 1 0 0 0)
}

function print_border {
  printf "%s\n" "$(printf '* --- %.0s' $(seq 1 $DISPLAY_GRID_WIDTH))""*"
}

function print_row {
  local row_start_idx=$(( $1 * $DISPLAY_GRID_WIDTH ))
  for (( i=0 ; i<$DISPLAY_GRID_WIDTH ; i++ )); do
    local cell_idx=$(( $row_start_idx + $i ))
    printf "|  %s  " "${DISPLAY_GRID[$cell_idx]}"
  done
  printf "|\n"
}

function next_gen_infinite_grid {
  # TO DO
  declare -A next_live_cells
  next_live_cells["1-0"]=1
  next_live_cells["1-1"]=1
  next_live_cells["1-2"]=1
  
  DISPLAY_GRID=()
  for (( y=0 ; y<$DISPLAY_GRID_WIDTH ; y++)); do
    for (( x=0 ; x<$DISPLAY_GRID_WIDTH ; x++)); do
      if [[ ${next_live_cells["$x-$y"]} -eq 1 ]]; then
        DISPLAY_GRID+=(1)
      else
        DISPLAY_GRID+=(0)
      fi
    done
  done
}

function next_gen_finite_grid {
  # TO DO
  local next_gen=("${DISPLAY_GRID[@]}")
  DISPLAY_GRID=("${next_gen[@]}")
}

function next_gen {
  if [[ $INFINITE_GRID -eq 1 ]]; then
    next_gen_infinite_grid
  else
    next_gen_finite_grid
  fi
}
