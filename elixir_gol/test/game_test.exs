defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "greets the world" do
    assert Game.hello() == :world
  end

  test "get neighbors of given cell" do
    neighbors = Game.get_neighbors_of(%{x: 0, y: 0})
    assert length(neighbors) == 8
    assert Enum.member?(neighbors, %{x: -1, y: -1})
    assert Enum.member?(neighbors, %{x: 0, y: -1})
    assert Enum.member?(neighbors, %{x: 1, y: -1})
    assert Enum.member?(neighbors, %{x: -1, y: 0})
    assert Enum.member?(neighbors, %{x: 1, y: 0})
    assert Enum.member?(neighbors, %{x: -1, y: 1})
    assert Enum.member?(neighbors, %{x: 0, y: 1})
    assert Enum.member?(neighbors, %{x: 1, y: 1})
  end

  test "get live neighbor count" do
    live_cells = [%{x: 1, y: 0}, %{x: 1, y: 1}, %{x: 1, y: 2}]

    live_neighbors00 = Game.get_live_neighbors_of(%{x: 0, y: 0}, live_cells)
    assert live_neighbors00 == 2

    live_neighbors10 = Game.get_live_neighbors_of(%{x: 1, y: 0}, live_cells)
    assert live_neighbors10 == 1

    live_neighbors01 = Game.get_live_neighbors_of(%{x: 0, y: 1}, live_cells)
    assert live_neighbors01 == 3

    live_neighbors11 = Game.get_live_neighbors_of(%{x: 1, y: 1}, live_cells)
    assert live_neighbors11 == 2
  end

  test "get next state of given cell" do
    live_cells = [%{x: 1, y: 0}, %{x: 1, y: 1}, %{x: 1, y: 2}]

    assert not Game.get_next_state_of(%{x: 0, y: 0}, live_cells)
    assert not Game.get_next_state_of(%{x: 1, y: 0}, live_cells)
    assert Game.get_next_state_of(%{x: 0, y: 1}, live_cells)
    assert Game.get_next_state_of(%{x: 1, y: 1}, live_cells)
  end

  test "get cells to check for next state" do
    live_cells = [%{x: 1, y: 0}, %{x: 1, y: 1}, %{x: 1, y: 2}]
    cells_to_check = Game.get_cells_to_check(live_cells)

    assert length(cells_to_check) == 15
    assert Enum.member?(cells_to_check, %{x: 0, y: -1})
    assert Enum.member?(cells_to_check, %{x: 1, y: -1})
    assert Enum.member?(cells_to_check, %{x: 2, y: -1})
    assert Enum.member?(cells_to_check, %{x: 0, y: 0})
    assert Enum.member?(cells_to_check, %{x: 1, y: 0})
    assert Enum.member?(cells_to_check, %{x: 2, y: 0})
    assert Enum.member?(cells_to_check, %{x: 0, y: 1})
    assert Enum.member?(cells_to_check, %{x: 1, y: 1})
    assert Enum.member?(cells_to_check, %{x: 2, y: 1})
    assert Enum.member?(cells_to_check, %{x: 0, y: 2})
    assert Enum.member?(cells_to_check, %{x: 1, y: 2})
    assert Enum.member?(cells_to_check, %{x: 2, y: 2})
    assert Enum.member?(cells_to_check, %{x: 0, y: 3})
    assert Enum.member?(cells_to_check, %{x: 1, y: 3})
    assert Enum.member?(cells_to_check, %{x: 2, y: 3})
  end

  test "get game next generation" do
    live_cells = [%{x: 1, y: 0}, %{x: 1, y: 1}, %{x: 1, y: 2}]
    next_gen = Game.get_next_gen(live_cells)

    assert length(next_gen) == 3
    assert Enum.member?(next_gen, %{x: 0, y: 1})
    assert Enum.member?(next_gen, %{x: 1, y: 1})
    assert Enum.member?(next_gen, %{x: 2, y: 1})
  end
end
