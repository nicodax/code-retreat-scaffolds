#!/usr/bin/env python3

# IMPORTS
import pygame
from game.game import Game

# CONSTANTS
BLACK = (0, 0, 0)
WHITE = (255, 255, 255)
GRID_SIZE = 10
BUTTON_SIZE = 50
BUTTON_MARGIN = 4
WINDOW_TITLE = "Conway's Game of Life"
WINDOW_SIZE = (BUTTON_SIZE*GRID_SIZE + BUTTON_MARGIN*(GRID_SIZE + 1), BUTTON_SIZE*GRID_SIZE + BUTTON_MARGIN*(GRID_SIZE + 1))
INFINITE_GRID=True

class Display:

    def __init__(self, screen, game):
        self.screen = screen
        self.game = game
        self.grid_colors = [[BLACK]*GRID_SIZE for _ in range(GRID_SIZE)]

    def draw(self):
        for row in range(GRID_SIZE):
            for column in range(GRID_SIZE):
                color = self.grid_colors[row][column]
                pygame.draw.rect(screen, color, [(BUTTON_MARGIN + BUTTON_SIZE) * column + BUTTON_MARGIN,
                                                (BUTTON_MARGIN + BUTTON_SIZE) * row + BUTTON_MARGIN,
                                                BUTTON_SIZE, BUTTON_SIZE])

    def handle_click(self, x, y):
        row = y // (BUTTON_SIZE + BUTTON_MARGIN)
        column = x // (BUTTON_SIZE + BUTTON_MARGIN)
        # TO DO
        #   * what happens whenever a grid cell is clicked ?
        cell_is_alive = (column, row) in self.game.live_cells
        self.grid_colors[row][column] = BLACK if cell_is_alive else WHITE
        if cell_is_alive:
            self.game.live_cells.remove((column, row))
        else:
            self.game.live_cells.append((column, row))

    def handle_keydown(self, key):
        if key == pygame.K_SPACE:
            self.next_gen()
        if key == pygame.K_r:
            self.reset_display()
            self.game.reset()

    def next_gen(self):
        if INFINITE_GRID:
            next_gen = self.game.get_next_gen_infinite_grid()
            # TO DO (INFINITE GRID)
            #   * update self.grid_colors according to next generation
            self.game.live_cells = next_gen
            self.grid_colors = [[BLACK]*GRID_SIZE for _ in range(GRID_SIZE)]
            for cell in next_gen:
                self.grid_colors[cell[1]][cell[0]] = WHITE
        else:
            next_gen = self.game.get_next_gen_finite_grid()
            # TO DO (FINITE GRID)
            #   * update self.grid_colors according to next generation

    def reset_display(self):
        self.grid_colors = [[BLACK]*GRID_SIZE for _ in range(GRID_SIZE)]

if __name__ == "__main__":
    pygame.init()
    screen = pygame.display.set_mode(WINDOW_SIZE)
    pygame.display.set_caption(WINDOW_TITLE)

    game = Game()
    display = Display(screen, game)

    done = False
    clock = pygame.time.Clock()
    while not done:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                done = True
            elif event.type == pygame.MOUSEBUTTONDOWN:
                if event.button == 1:
                    display.handle_click(*event.pos)
            elif event.type == pygame.KEYDOWN:
                display.handle_keydown(event.key)

        screen.fill(WHITE)
        display.draw()

        pygame.display.flip()
        clock.tick(60)

    pygame.quit()
