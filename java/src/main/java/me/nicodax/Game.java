package me.nicodax;

import lombok.Getter;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import static java.lang.Math.toIntExact;
import static me.nicodax.CellStatus.ALIVE;
import static me.nicodax.CellStatus.DEAD;

public class Game {

    private final Integer GRID_SIZE;
    @Getter
    private final List<List<Cell>> grid = new ArrayList<>();

    public Game(Integer gridSize) {
        this.GRID_SIZE = gridSize;
        for (int y = 0; y < gridSize; y++) {
            List<Cell> row = new ArrayList<>();
            for (int x = 0; x < gridSize; x++) {
                row.add(new Cell(x, y, DEAD));
            }
            grid.add(row);
        }
    }

    public Set<Cell> getNeighborsOf(Cell cell) {
        Set<Cell> neighbors = new HashSet<>();
        int xStart = cell.getX() - 1 >= 0 ? cell.getX() - 1 : cell.getX();
        int yStart = cell.getY() - 1 >= 0 ? cell.getY() - 1 : cell.getY();
        int xEnd = cell.getX() + 1 < GRID_SIZE ? cell.getX() + 1 : cell.getX();
        int yEnd = cell.getY() + 1 < GRID_SIZE ? cell.getY() + 1 : cell.getY();
        for (int y = yStart; y <= yEnd; y++) {
            for (int x = xStart; x <= xEnd; x++) {
                neighbors.add(grid.get(y).get(x));
            }
        }
        neighbors.remove(cell);
        return neighbors;
    }

    public Integer getLiveNeighborCountOf(Cell cell) {
        Set<Cell> neighbors = getNeighborsOf(cell);
        return toIntExact(neighbors.stream().filter(neighbor -> neighbor.getStatus().equals(ALIVE)).count());
    }

    public CellStatus getNextStatusOf(Cell cell) {
        Integer liveNeighborCount = getLiveNeighborCountOf(cell);
        if (cell.getStatus().equals(ALIVE) && liveNeighborCount >= 2 && liveNeighborCount <= 3) return ALIVE;
        else if (cell.getStatus().equals(DEAD) && liveNeighborCount == 3) return ALIVE;
        return DEAD;
    }

    public List<List<Cell>> getNextGen() {
        List<List<Cell>> nextGen = new ArrayList<>();
        for (List<Cell> row : grid) {
            List<Cell> nextGenRow = new ArrayList<>();
            for (Cell cell : row) {
                nextGenRow.add(new Cell(cell.getX(), cell.getY(), getNextStatusOf(cell)));
            }
            nextGen.add(nextGenRow);
        }
        return nextGen;
    }
}
