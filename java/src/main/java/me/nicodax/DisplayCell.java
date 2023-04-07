package me.nicodax;

import lombok.Getter;

import javax.swing.JButton;

import java.util.Objects;

import static java.awt.Color.*;
import static javax.swing.BorderFactory.createLineBorder;
import static me.nicodax.CellStatus.ALIVE;
import static me.nicodax.CellStatus.DEAD;

public class DisplayCell extends JButton {
    private final Display display;
    @Getter
    private CellStatus status = DEAD;
    @Getter
    private final Integer row;
    @Getter
    private final Integer col;

    public DisplayCell(Display display, Integer col, Integer row) {
        this.display = display;
        this.row = row;
        this.col = col;
        setUpJButton();
    }

    private void setUpJButton() {
        setBackground(BLACK);
        setBorderPainted(true);
        setFocusable(false);
        setBorder(createLineBorder(WHITE, 1));
        addActionListener(e -> toggleState());
    }

    private void toggleState() {
        if (status.equals(ALIVE)) setDead();
        else if (status.equals(DEAD)) setAlive();
    }

    public void setAlive() {
        status = ALIVE;
        setBackground(CellStatus.mapToBackgroundColor(status));
        display.getCurrentLiveDisplayCells().add(this);
    }

    public void setDead() {
        status = DEAD;
        setBackground(CellStatus.mapToBackgroundColor(status));
        display.getCurrentLiveDisplayCells().remove(this);
    }

    public Boolean isDisplayed() {
        return col >= 0 &&
                col < display.getGRID_SIZE() &&
                row >= 0 &&
                row < display.getGRID_SIZE();
    }

    @Override
    public boolean equals(Object o) {
        if (o == this) return true;
        if (!(o instanceof DisplayCell other)) return false;
        return Objects.equals(other.col, col) && Objects.equals(other.row, row);
    }

    @Override
    public int hashCode() {
        return Objects.hash(col, row);
    }

    @Override
    public String toString() {
        return "(" + col + ", " + row + ", " + status + ")";
    }
}