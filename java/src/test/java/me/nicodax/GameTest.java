package me.nicodax;

import org.junit.jupiter.api.Test;

import java.util.List;
import java.util.Set;

import static me.nicodax.CellStatus.ALIVE;
import static me.nicodax.CellStatus.DEAD;
import static org.junit.jupiter.api.Assertions.*;

class GameTest {
    private final Integer GRID_SIZE = 3;

    @Test
    void getNeighborsOf_cornerCell() {
        Game game = new Game(GRID_SIZE);
        Cell cell = new Cell(0, 0, DEAD);
        Set<Cell> neighbors = game.getNeighborsOf(cell);

        assertEquals(3, neighbors.size());
        assertTrue(neighbors.contains(new Cell(1, 0, DEAD)));
        assertTrue(neighbors.contains(new Cell(0, 1, DEAD)));
        assertTrue(neighbors.contains(new Cell(1, 1, DEAD)));
    }

    @Test
    void getNeighborsOf_edgeCell() {
        Game game = new Game(GRID_SIZE);
        Cell cell = new Cell(1, 0, DEAD);
        Set<Cell> neighbors = game.getNeighborsOf(cell);

        assertEquals(5, neighbors.size());
        assertTrue(neighbors.contains(new Cell(0, 0, DEAD)));
        assertTrue(neighbors.contains(new Cell(2, 0, DEAD)));
        assertTrue(neighbors.contains(new Cell(0, 1, DEAD)));
        assertTrue(neighbors.contains(new Cell(1, 1, DEAD)));
        assertTrue(neighbors.contains(new Cell(2, 1, DEAD)));
    }

    @Test
    void getNeighborsOf_others() {
        Game game = new Game(GRID_SIZE);
        Cell cell = new Cell(1, 1, DEAD);
        Set<Cell> neighbors = game.getNeighborsOf(cell);

        assertEquals(8, neighbors.size());
        assertTrue(neighbors.contains(new Cell(0, 0, DEAD)));
        assertTrue(neighbors.contains(new Cell(1, 0, DEAD)));
        assertTrue(neighbors.contains(new Cell(2, 0, DEAD)));
        assertTrue(neighbors.contains(new Cell(0, 1, DEAD)));
        assertTrue(neighbors.contains(new Cell(2, 1, DEAD)));
        assertTrue(neighbors.contains(new Cell(0, 2, DEAD)));
        assertTrue(neighbors.contains(new Cell(1, 2, DEAD)));
        assertTrue(neighbors.contains(new Cell(2, 2, DEAD)));
    }

    @Test
    void getLiveNeighborCountOf() {
        Game game = setupBasicVerticalSpinner();

        assertEquals(2, game.getLiveNeighborCountOf(new Cell(0, 0, DEAD)));
        assertEquals(3, game.getLiveNeighborCountOf(new Cell(0, 1, DEAD)));
        assertEquals(1, game.getLiveNeighborCountOf(new Cell(1, 0, ALIVE)));
        assertEquals(2, game.getLiveNeighborCountOf(new Cell(1, 1, ALIVE)));

    }

    @Test
    void getNextStatusOf() {
        Game game = setupBasicVerticalSpinner();

        assertEquals(DEAD, game.getNextStatusOf(new Cell(0, 0, DEAD)));
        assertEquals(DEAD, game.getNextStatusOf(new Cell(1, 0, ALIVE)));
        assertEquals(DEAD, game.getNextStatusOf(new Cell(2, 0, DEAD)));
        assertEquals(ALIVE, game.getNextStatusOf(new Cell(0, 1, DEAD)));
        assertEquals(ALIVE, game.getNextStatusOf(new Cell(1, 1, ALIVE)));
        assertEquals(ALIVE, game.getNextStatusOf(new Cell(2, 1, DEAD)));
        assertEquals(DEAD, game.getNextStatusOf(new Cell(0, 2, DEAD)));
        assertEquals(DEAD, game.getNextStatusOf(new Cell(1, 2, ALIVE)));
        assertEquals(DEAD, game.getNextStatusOf(new Cell(2, 2, DEAD)));
    }

    @Test
    void getNextGen() {
        Game game = setupBasicVerticalSpinner();
        List<List<Cell>> nextGen = game.getNextGen();

        assertEquals(GRID_SIZE, nextGen.size());
        assertEquals(GRID_SIZE, nextGen.get(0).size());
        assertEquals(DEAD, nextGen.get(0).get(0).getStatus());
        assertEquals(DEAD, nextGen.get(0).get(1).getStatus());
        assertEquals(DEAD, nextGen.get(0).get(2).getStatus());
        assertEquals(ALIVE, nextGen.get(1).get(0).getStatus());
        assertEquals(ALIVE, nextGen.get(1).get(1).getStatus());
        assertEquals(ALIVE, nextGen.get(1).get(2).getStatus());
        assertEquals(DEAD, nextGen.get(2).get(0).getStatus());
        assertEquals(DEAD, nextGen.get(2).get(1).getStatus());
        assertEquals(DEAD, nextGen.get(2).get(2).getStatus());
    }

    private Game setupBasicVerticalSpinner() {
        Game game = new Game(GRID_SIZE);
        Cell liveCell1 = new Cell(1, 0, ALIVE);
        Cell liveCell2 = new Cell(1, 1, ALIVE);
        Cell liveCell3 = new Cell(1, 2, ALIVE);
        game.getGrid().get(liveCell1.getY()).get(liveCell1.getX()).setStatus(ALIVE);
        game.getGrid().get(liveCell2.getY()).get(liveCell2.getX()).setStatus(ALIVE);
        game.getGrid().get(liveCell3.getY()).get(liveCell3.getX()).setStatus(ALIVE);
        return game;
    }
}