#!/bin/bash
DISPLAY_GRID_WIDTH=3
INIT=(0 0 0 1 1 1 0 0 0)
DISPLAY_GRID=()
INFINITE_GRID=1
declare -A LIVE_CELLS=()
declare -A CELLS_TO_CHECK=()

function init_display_grid_with_vertical_spinner {
  GRID_WIDTH=3
  DISPLAY_GRID=(0 1 0 0 1 0 0 1 0)
  LIVE_CELLS=()
  LIVE_CELLS["1_0"]=1
  LIVE_CELLS["1_1"]=1
  LIVE_CELLS["1_2"]=1
}

function init_display_grid_with_horizontal_spinner {
  DISPLAY_GRID_WIDTH=3
  DISPLAY_GRID=(0 0 0 1 1 1 0 0 0)
  LIVE_CELLS=()
  LIVE_CELLS["0_1"]=1
  LIVE_CELLS["1_1"]=1
  LIVE_CELLS["2_1"]=1
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
  declare -A next_live_cells

  get_cells_to_check
  for key in "${!CELLS_TO_CHECK[@]}"; do
    IFS="_" read -r currentx currenty <<< "$key"
    next_state=$(get_next_state_of $currentx $currenty)
    if [[ $next_state -eq 1 ]]; then
      next_live_cells["${currentx}_${currenty}"]=1
    fi
  done

  DISPLAY_GRID=()
  LIVE_CELLS=()
  for (( y=0 ; y<$DISPLAY_GRID_WIDTH ; y++)); do
    for (( x=0 ; x<$DISPLAY_GRID_WIDTH ; x++)); do
      if [[ ${next_live_cells["${x}_${y}"]} -eq 1 ]]; then
        DISPLAY_GRID+=(1)
        LIVE_CELLS["${x}_${y}"]=1
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
  local neighbors=()
  for (( yn=(( $cell_y - 1 )) ; yn<=(( $cell_y + 1 )) ; yn++ )); do
    for (( xn=(( $cell_x - 1 )) ; xn<=(( $cell_x + 1 )) ; xn++ )); do
      if [[ ! ((xn -eq $cell_x && yn -eq $cell_y)) ]]; then
        neighbors+=("${xn}_${yn}")
      fi
    done
  done
  echo "${neighbors[@]}"
}

function get_live_neighbor_count_of {
  local cell_x=$1
  local cell_y=$2
  local neighbors=($(get_neighbors_of $cell_x $cell_y))
  local live_neighbor_count=0
  for neighbor in "${neighbors[@]}"; do
    if [[ -v ${LIVE_CELLS["$neighbor"]} ]]; then
      (( live_neighbor_count++ ))
    fi
  done
  echo $live_neighbor_count
}

function get_next_state_of {
  local x=$1
  local y=$2
  local live_neighbor_count=$(get_live_neighbor_count_of $x $y)
  if [[ -v ${LIVE_CELLS["${x}_${y}"]} && $live_neighbor_count -ge 2 && $live_neighbor_count -le 3 ]]; then
    echo 1
  elif [[ ! (( -v ${LIVE_CELLS["${x}_${y}"]} )) && $live_neighbor_count -eq 3 ]]; then
    echo 1
  else
    echo 0
  fi
}

function get_cells_to_check {
  CELLS_TO_CHECK=()
  declare -A neighbors=()
  for key in "${!LIVE_CELLS[@]}"; do
    CELLS_TO_CHECK[$key]=1
    IFS="_" read -r currentx currenty <<< "$key"
    local current_neighbors=($(get_neighbors_of $currentx $currenty))
    for neighbor in "${current_neighbors[@]}"; do
      CELLS_TO_CHECK[$neighbor]=1
    done
  done
}