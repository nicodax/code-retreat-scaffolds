package me.nicodax;

import lombok.Getter;
import lombok.Setter;

import java.util.HashSet;
import java.util.Set;

import static java.lang.Math.toIntExact;
import static java.util.stream.Collectors.toSet;
import static me.nicodax.CellState.ALIVE;
import static me.nicodax.CellState.DEAD;

public class Game {

    @Getter
    @Setter
    private Set<Cell> liveCells = new HashSet<>();

    public Set<Cell> getNeighborsOf(Cell cell) {
        Set<Cell> neighbors = new HashSet<>();
        neighbors.add(new Cell(cell.x() - 1, cell.y() - 1));
        neighbors.add(new Cell(cell.x(), cell.y() - 1));
        neighbors.add(new Cell(cell.x() + 1, cell.y() - 1));
        neighbors.add(new Cell(cell.x() - 1, cell.y()));
        neighbors.add(new Cell(cell.x() + 1, cell.y()));
        neighbors.add(new Cell(cell.x() - 1, cell.y() + 1));
        neighbors.add(new Cell(cell.x(), cell.y() + 1));
        neighbors.add(new Cell(cell.x() + 1, cell.y() + 1));
        return neighbors;
    }

    public Integer getLiveNeighborCount(Set<Cell> neighbors) {
        return toIntExact(neighbors.stream().filter(cell -> liveCells.contains(cell)).count());
    }

    public CellState getNextState(Cell cell) {
        Integer liveNeighborCount = getLiveNeighborCount(getNeighborsOf(cell));
        if (liveCells.contains(cell) && liveNeighborCount >= 2 && liveNeighborCount <= 3) return ALIVE;
        if (!liveCells.contains(cell) && liveNeighborCount == 3) return ALIVE;
        return DEAD;
    }

    public Set<Cell> getCellsToCheck() {
        Set<Cell> cellsToCheck = new HashSet<>(liveCells);
        for (Cell cell : liveCells) {
            cellsToCheck.addAll(getNeighborsOf(cell));
        }
        return cellsToCheck;
    }

    public Set<Cell> getNextGen() {
        return getCellsToCheck().stream().filter(cell -> getNextState(cell).equals(ALIVE)).collect(toSet());
    }
}
