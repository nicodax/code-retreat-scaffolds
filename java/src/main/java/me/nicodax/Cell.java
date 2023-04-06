package me.nicodax;

import lombok.Getter;
import lombok.Setter;

import java.util.Objects;

public class Cell {

    @Getter
    private final Integer x;
    @Getter
    private final Integer y;
    @Getter
    @Setter
    private CellStatus status;

    public Cell(Integer x, Integer y, CellStatus status) {
        this.x = x;
        this.y = y;
        this.status = status;
    }

    @Override
    public boolean equals(Object o) {
        if (o == this) return true;
        if (!(o instanceof Cell other)) return false;
        return Objects.equals(other.getX(), x) && Objects.equals(other.getY(), y);
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y);
    }
}
