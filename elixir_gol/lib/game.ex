defmodule Game do
  @moduledoc """
  Documentation for `Game`.
  """

  @typedoc """
  a cell with x and y coordinates
  """
  @type cell_t :: %{
    x: integer,
    y: integer
  }

  @doc """
  Hello world.

  ## Examples

      iex> Game.hello()
      :world

  """
  def hello do
    :world
  end

  @doc """
  Gets given cell neighbors

  ## Examples

      iex> Game.get_neighbors_of(%{x: 0, y: 0})
      [
        %{x: -1, y: -1},
        %{x: 0, y: -1},
        %{x: 1, y: -1},
        %{x: -1, y: 0},
        %{x: 1, y: 0},
        %{x: -1, y: 1},
        %{x: 0, y: 1},
        %{x: 1, y: 1}
      ]
  """
  @spec get_neighbors_of(cell_t) :: [cell_t]
  def get_neighbors_of(cell) do
    loop_over_neighbors([], cell.x - 1, cell.y - 1, cell.x + 1, cell.y + 1)
  end
  
  @spec loop_over_neighbors([cell_t], integer, integer, integer, integer) :: [cell_t]
  defp loop_over_neighbors(neighbors_prev, x, y, maxX, maxY) when x <= maxX and y <= maxY do
    neighbors = neighbors_prev ++ [%{x: x, y: y}]
    {x, y} = increment_x_y_counters(x, y, maxX, maxY)
    loop_over_neighbors(neighbors, x, y, maxX, maxY)
  end
  
  defp loop_over_neighbors(neighbors, _x, _y, maxX, maxY) do
    List.delete(neighbors, %{x: maxX - 1, y: maxY - 1})
  end
  
  @spec increment_x_y_counters(integer, integer, integer, integer) :: {integer, integer}
  defp increment_x_y_counters(x, y, maxX, maxY) do
    cond do
      x == maxX ->
        {x - 2, y + 1}
      x == maxX and y == maxY ->
        {x, y}
      true ->
        {x + 1, y}
    end
  end

  @doc """
  Gets given cell live neighbors count

  ## Examples

      iex> Game.get_live_neighbors_of(%{x: 0, y: 0}, [%{x: 1, y: 0}, %{x: 1, y: 1}, %{x: 1, y: 2}])
      2
  """
  @spec get_live_neighbors_of(cell_t, [cell_t]) :: integer
  def get_live_neighbors_of(cell, live_cells) do
    neighbors = get_neighbors_of(cell)
    live_neighbors = Enum.filter(neighbors, fn cell -> alive?(cell, live_cells) end)
    length(live_neighbors)
  end

  @spec alive?(cell_t, [cell_t]) :: boolean
  def alive?(cell, live_cells) do
    Enum.member?(live_cells, cell)
  end

  @doc """
  Gets given cell's next based of gol's rules
  
  ## Examples

      iex> Game.get_next_state_of(%{x: 0, y: 0}, [%{x: 1, y: 0}, %{x: 1, y: 1}, %{x: 1, y: 2}])
      false
  """
  @spec get_next_state_of(cell_t, [cell_t]) :: boolean
  def get_next_state_of(cell, live_cells) do
    live_neighbor_count = get_live_neighbors_of(cell, live_cells)
    cond do
      alive?(cell, live_cells) and live_neighbor_count >= 2 and live_neighbor_count <= 3 ->
        true
      true ->
        not alive?(cell, live_cells) and live_neighbor_count == 3
    end
  end

  @doc """
  Gets cells to check for the next generation
  ## Examples

      iex> Game.get_cells_to_check([%{x: 1, y: 0}, %{x: 1, y: 1}, %{x: 1, y: 2}])
      [
        %{x: 0, y: -1},
        %{x: 1, y: -1},
        %{x: 2, y: -1},
        %{x: 0, y: 0},
        %{x: 1, y: 0},
        %{x: 2, y: 0},
        %{x: 0, y: 1},
        %{x: 1, y: 1},
        %{x: 2, y: 1},
        %{x: 0, y: 2},
        %{x: 1, y: 2},
        %{x: 2, y: 2},
        %{x: 0, y: 3},
        %{x: 1, y: 3},
        %{x: 2, y: 3},
      ]
  """
  @spec get_cells_to_check([cell_t]) :: [cell_t]
  def get_cells_to_check(live_cells) do
    live_cells
    |> Enum.reduce([], &(&2 ++ get_neighbors_of(&1)))
    |> Enum.uniq()
    |> Enum.sort(&compare_cells/2)
  end

  @spec compare_cells(cell_t, cell_t) :: boolean
  defp compare_cells(cell1, cell2) do
    cond do
      cell1.y != cell2.y ->
        cell1.y < cell2.y
      true ->
        cell1.x < cell2.x
    end
  end

  @doc """
  Gets game next generation
  ## Examples

      iex> Game.get_next_gen([%{x: 1, y: 0}, %{x: 1, y: 1}, %{x: 1, y: 2}])
      [
        %{x: 0, y: 1},
        %{x: 1, y: 1},
        %{x: 2, y: 1}
      ]
  """
  @spec get_next_gen([cell_t]) :: [cell_t]
  def get_next_gen(live_cells) do
    live_cells
    |> get_cells_to_check()
    |> Enum.filter(&get_next_state_of(&1, live_cells))
  end
end
