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

function get_neighbors_of {
  local cell_x=$1
  local cell_y=$2
  local startx=$(( cell_x > 0 ? cell_x - 1 : cell_x ))
  local starty=$(( cell_y > 0 ? cell_y - 1 : cell_y ))
  local endx=$(( cell_x < GRID_WIDTH-1 ? cell_x + 1 : cell_x ))
  local endy=$(( cell_y < GRID_WIDTH-1 ? cell_y + 1 : cell_y ))
  local neighbors=()
  for (( zy=starty ; zy<=endy ; zy++ )); do
    for (( zx=startx ; zx<=endx ; zx++ )); do
      if (( zx == cell_x && zy == cell_y )); then
        continue
      fi
      local z_idx=$(( (zy * GRID_WIDTH) + zx ))
      neighbors+=("${DISPLAY_GRID[$z_idx]}")
    done
  done
  echo "${neighbors[@]}"
}

function get_live_neighbor_count_from {
  local neighbors=("$@")
  local live_neighbor_count=0
  for neighbor in "${neighbors[@]}"; do
    if (( neighbor == 1 )); then
      (( live_neighbor_count++ ))
    fi
  done
  echo "$live_neighbor_count"
}

function get_next_state_of {
  local cell_x=$1
  local cell_y=$2
  local cell_idx=$(( (cell_y * GRID_WIDTH) + cell_x ))
  local neighbors=($(get_neighbors_of "$cell_x" "$cell_y"))
  local live_neighbor_count=$(get_live_neighbor_count_from "${neighbors[@]}")
  if (( DISPLAY_GRID[$cell_idx] == 1 && live_neighbor_count >= 2 && live_neighbor_count <= 3 )); then
    echo 1
  elif (( DISPLAY_GRID[$cell_idx] == 0 && live_neighbor_count == 3 )); then
    echo 1
  else
    echo 0
  fi
}
