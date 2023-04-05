package me.nicodax;

import org.junit.Test;

import java.util.Set;

import static me.nicodax.CellState.ALIVE;
import static me.nicodax.CellState.DEAD;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

public class GameTest {

    @Test
    public void getNeighborsOf() {
        Game game = new Game();
        Cell cell = new Cell(0, 0);
        Set<Cell> neighbors = game.getNeighborsOf(cell);

        assertEquals(8, neighbors.size());
        assertTrue(neighbors.contains(new Cell(-1, -1)));
        assertTrue(neighbors.contains(new Cell(0, -1)));
        assertTrue(neighbors.contains(new Cell(1, -1)));
        assertTrue(neighbors.contains(new Cell(-1, 0)));
        assertTrue(neighbors.contains(new Cell(1, 0)));
        assertTrue(neighbors.contains(new Cell(-1, 1)));
        assertTrue(neighbors.contains(new Cell(0, 1)));
        assertTrue(neighbors.contains(new Cell(-1, 1)));
    }

    @Test
    public void getLiveNeighborCount() {
        Game game = new Game();
        game.getLiveCells().add(new Cell(0, 1));
        game.getLiveCells().add(new Cell(1, 1));
        game.getLiveCells().add(new Cell(2, 1));

        Cell cell1 = new Cell(0, 0);
        Integer cell1Count = game.getLiveNeighborCount(game.getNeighborsOf(cell1));
        Integer expectedCount1 = 2;

        Cell cell2 = new Cell(1, 0);
        Integer cell2Count = game.getLiveNeighborCount(game.getNeighborsOf(cell2));
        Integer expectedCount2 = 3;

        Cell cell3 = new Cell(0, 1);
        Integer cell3Count = game.getLiveNeighborCount(game.getNeighborsOf(cell3));
        Integer expectedCount3 = 1;

        Cell cell4 = new Cell(1, 1);
        Integer cell4Count = game.getLiveNeighborCount(game.getNeighborsOf(cell4));
        Integer expectedCount4 = 2;

        assertEquals(expectedCount1, cell1Count);
        assertEquals(expectedCount2, cell2Count);
        assertEquals(expectedCount3, cell3Count);
        assertEquals(expectedCount4, cell4Count);
    }

    @Test
    public void getNextState() {
        Game game = new Game();
        game.getLiveCells().add(new Cell(0, 1));
        game.getLiveCells().add(new Cell(1, 1));
        game.getLiveCells().add(new Cell(2, 1));

        Cell cell1 = new Cell(0, 0);
        CellState state1 = game.getNextState(cell1);

        Cell cell2 = new Cell(1, 0);
        CellState state2 = game.getNextState(cell2);

        Cell cell3 = new Cell(0, 1);
        CellState state3 = game.getNextState(cell3);

        Cell cell4 = new Cell(1, 1);
        CellState state4 = game.getNextState(cell4);

        assertEquals(DEAD, state1);
        assertEquals(ALIVE, state2);
        assertEquals(DEAD, state3);
        assertEquals(ALIVE, state4);
    }

    @Test
    public void getCellsToCheck() {
        Game game = new Game();
        game.getLiveCells().add(new Cell(0, 1));
        game.getLiveCells().add(new Cell(1, 1));
        game.getLiveCells().add(new Cell(2, 1));

        assertEquals(15, game.getCellsToCheck().size());

        assertTrue(game.getCellsToCheck().contains(new Cell(-1, 0)));
        assertTrue(game.getCellsToCheck().contains(new Cell(0, 0)));
        assertTrue(game.getCellsToCheck().contains(new Cell(1, 0)));
        assertTrue(game.getCellsToCheck().contains(new Cell(2, 0)));
        assertTrue(game.getCellsToCheck().contains(new Cell(3, 0)));

        assertTrue(game.getCellsToCheck().contains(new Cell(-1, 1)));
        assertTrue(game.getCellsToCheck().contains(new Cell(0, 1)));
        assertTrue(game.getCellsToCheck().contains(new Cell(1, 1)));
        assertTrue(game.getCellsToCheck().contains(new Cell(2, 1)));
        assertTrue(game.getCellsToCheck().contains(new Cell(3, 1)));

        assertTrue(game.getCellsToCheck().contains(new Cell(-1, 2)));
        assertTrue(game.getCellsToCheck().contains(new Cell(0, 2)));
        assertTrue(game.getCellsToCheck().contains(new Cell(1, 2)));
        assertTrue(game.getCellsToCheck().contains(new Cell(2, 2)));
        assertTrue(game.getCellsToCheck().contains(new Cell(3, 2)));
    }

    @Test
    public void getNextGen() {
        Game game = new Game();
        game.getLiveCells().add(new Cell(0, 1));
        game.getLiveCells().add(new Cell(1, 1));
        game.getLiveCells().add(new Cell(2, 1));

        Set<Cell> nextGen = game.getNextGen();
        assertEquals(3, nextGen.size());

        assertTrue(nextGen.contains(new Cell(1, 0)));
        assertTrue(nextGen.contains(new Cell(1, 1)));
        assertTrue(nextGen.contains(new Cell(1, 2)));
    }
}