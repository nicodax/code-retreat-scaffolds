package me.nicodax;

import javax.swing.JFrame;

public class Main {
    private final static String FRAME_TITLE = "Conway's Game of Life";
    private final static Integer FRAME_SIZE = 800;
    private final static Integer GRID_SIZE = 20;
    private final static Boolean INFINITE_GRID = true;

    public static void main(String[] args) {
        JFrame frame = new JFrame(FRAME_TITLE);
        Display display = new Display(GRID_SIZE, INFINITE_GRID);

        frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.getContentPane().add(display);
        frame.setSize(FRAME_SIZE, FRAME_SIZE);
        frame.setVisible(true);
        frame.setLocationRelativeTo(null);
    }
}