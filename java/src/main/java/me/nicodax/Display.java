package me.nicodax;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.awt.*;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.swing.JPanel;

import static me.nicodax.CellStatus.ALIVE;

@NoArgsConstructor(force = true)
public class Display extends JPanel implements KeyListener {

    @Getter
    private final Boolean INFINITE_GRID;
    @Getter
    private final List<List<DisplayCell>> displayedCells = new ArrayList<>();
    @Getter
    private Set<DisplayCell> currentLiveDisplayCells = new HashSet<>();
    @Getter
    private Set<DisplayCell> nextGenLiveDisplayCells = new HashSet<>();
    @Getter
    private final Integer GRID_SIZE;

    public Display(Integer gridSize, Boolean infiniteGrid) {
        this.INFINITE_GRID = infiniteGrid;
        this.GRID_SIZE = gridSize;
        setLayout(new GridLayout(gridSize, gridSize));
        addKeyListener(this);
        setFocusable(true);

        for (int row = 0; row < gridSize; row++) {
            List<DisplayCell> displayCellRow = new ArrayList<>();
            for (int col = 0; col < gridSize; col++) {
                DisplayCell displayCell = new DisplayCell(this, col, row);
                displayCellRow.add(displayCell);
                this.add(displayCell);
            }
            displayedCells.add(displayCellRow);
        }
    }

    protected void setNextGen() {
        if (getINFINITE_GRID()) setNextGenWithInfiniteGrid();
        else setNextGenWithFiniteGrid();
        displayNextGen();
    }

    protected void setNextGenWithInfiniteGrid() {
        // TO DO
        nextGenLiveDisplayCells = new HashSet<>(currentLiveDisplayCells);
    }

    protected void setNextGenWithFiniteGrid() {
        // TO DO
        Set<DisplayCell> nextLiveDisplayCells = new HashSet<>();
        displayedCells.forEach(row -> row.stream()
                .filter(displayCell -> displayCell.getStatus().equals(ALIVE))
                .forEach(nextLiveDisplayCells::add)
        );
        nextGenLiveDisplayCells = new HashSet<>(nextLiveDisplayCells);
    }

    public void displayNextGen() {
        displayedCells.forEach(row -> row.forEach(DisplayCell::setDead));
        nextGenLiveDisplayCells.stream()
                .filter(DisplayCell::isDisplayed)
                .forEach(displayCell -> displayedCells.get(displayCell.getRow()).get(displayCell.getCol()).setAlive());
        currentLiveDisplayCells = new HashSet<>(nextGenLiveDisplayCells);
        nextGenLiveDisplayCells = new HashSet<>();
    }

    public void reset() {
        currentLiveDisplayCells = new HashSet<>();
        displayedCells.forEach(row -> row.forEach(DisplayCell::setDead));
    }

    @Override
    public void keyPressed(KeyEvent e) {
        if (e.getKeyCode() == KeyEvent.VK_SPACE) setNextGen();
        if (e.getKeyCode() == KeyEvent.VK_R) reset();
    }

    @Override
    public void keyReleased(KeyEvent e) { }

    @Override
    public void keyTyped(KeyEvent e) { }
}
