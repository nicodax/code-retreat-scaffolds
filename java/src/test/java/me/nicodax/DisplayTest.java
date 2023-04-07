package me.nicodax;

import org.junit.jupiter.api.Test;
import org.mockito.MockitoAnnotations;
import org.mockito.Spy;

import java.util.List;

import static me.nicodax.CellStatus.DEAD;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

class DisplayTest {

    @Spy
    private Display mockedDisplay;

    private void initMocks() {
        MockitoAnnotations.openMocks(this);
    }

    @Test
    public void testConstructor() {
        Integer GRID_SIZE = 3;
        Boolean INFINITE_GRID = true;
        Boolean FINITE_GRID = false;
        Display displayInfiniteGrid = new Display(GRID_SIZE, INFINITE_GRID);
        Display displayFiniteGrid = new Display(GRID_SIZE, FINITE_GRID);

        assertEquals(GRID_SIZE, displayInfiniteGrid.getGRID_SIZE());
        assertEquals(GRID_SIZE, displayFiniteGrid.getGRID_SIZE());

        assertEquals(true, displayInfiniteGrid.getINFINITE_GRID());
        assertEquals(false, displayFiniteGrid.getINFINITE_GRID());

        assertEquals(GRID_SIZE, displayFiniteGrid.getDisplayedCells().size());
        assertEquals(GRID_SIZE, displayInfiniteGrid.getDisplayedCells().size());
        assertEquals(GRID_SIZE, displayFiniteGrid.getDisplayedCells().get(0).size());
        assertEquals(GRID_SIZE, displayInfiniteGrid.getDisplayedCells().get(0).size());
    }

    @Test
    void setNextGen_infiniteGrid() {
        initMocks();
        when(mockedDisplay.getINFINITE_GRID()).thenReturn(true);

        mockedDisplay.setNextGen();

        verify(mockedDisplay, times(1)).setNextGenWithInfiniteGrid();
        verify(mockedDisplay, times(0)).setNextGenWithFiniteGrid();
        verify(mockedDisplay, times(1)).displayNextGen();
    }

    @Test
    void setNextGen_finiteGrid() {
        initMocks();
        when(mockedDisplay.getINFINITE_GRID()).thenReturn(false);

        mockedDisplay.setNextGen();

        verify(mockedDisplay, times(0)).setNextGenWithInfiniteGrid();
        verify(mockedDisplay, times(1)).setNextGenWithFiniteGrid();
        verify(mockedDisplay, times(1)).displayNextGen();
    }

    @Test
    void displayNextGen_infiniteGrid() {
        Integer GRID_SIZE = 3;
        Boolean INFINITE_GRID = true;
        Display display = new Display(GRID_SIZE, INFINITE_GRID);
        display.getCurrentLiveDisplayCells().add(new DisplayCell(display, 1, 0));
        display.getCurrentLiveDisplayCells().add(new DisplayCell(display, 1, 1));
        display.getCurrentLiveDisplayCells().add(new DisplayCell(display, 1, 2));

        display.getNextGenLiveDisplayCells().add(new DisplayCell(display, 0, 1));
        display.getNextGenLiveDisplayCells().add(new DisplayCell(display, 1, 1));
        display.getNextGenLiveDisplayCells().add(new DisplayCell(display, 2, 1));

        display.displayNextGen();

        assertEquals(3, display.getCurrentLiveDisplayCells().size());
        assertTrue(display.getCurrentLiveDisplayCells().contains(new DisplayCell(display, 0, 1)));
        assertTrue(display.getCurrentLiveDisplayCells().contains(new DisplayCell(display, 1, 1)));
        assertTrue(display.getCurrentLiveDisplayCells().contains(new DisplayCell(display, 2, 1)));

        assertEquals(0, display.getNextGenLiveDisplayCells().size());
    }

    @Test
    void reset() {
        Integer GRID_SIZE = 3;
        Boolean INFINITE_GRID = true;
        Display display = new Display(GRID_SIZE, INFINITE_GRID);
        display.getCurrentLiveDisplayCells().add(new DisplayCell(display, 1, 0));
        display.getCurrentLiveDisplayCells().add(new DisplayCell(display, 1, 1));
        display.getCurrentLiveDisplayCells().add(new DisplayCell(display, 1, 2));
        display.getDisplayedCells().get(0).get(1).setAlive();
        display.getDisplayedCells().get(1).get(1).setAlive();
        display.getDisplayedCells().get(2).get(1).setAlive();

        display.reset();

        assertEquals(0, display.getCurrentLiveDisplayCells().size());
        for (List<DisplayCell> row : display.getDisplayedCells()) {
            for (DisplayCell cell : row) {
                assertEquals(cell.getStatus(), DEAD);
            }
        }
    }
}