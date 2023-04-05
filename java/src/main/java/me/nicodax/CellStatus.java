package me.nicodax;

import java.awt.*;

import static java.awt.Color.BLACK;
import static java.awt.Color.WHITE;

public enum CellStatus {
    DEAD, ALIVE;

    public static Color mapToBackgroundColor(CellStatus status) {
        return status.equals(ALIVE) ? WHITE : BLACK;
    }
}
