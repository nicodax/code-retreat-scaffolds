#!/usr/bin/env python3

class Game:
    def __init__(self, grid_size=3):
        self.grid_size = grid_size
        self.grid = [[0 for _ in range(grid_size)] for _ in range(grid_size)]

    def hello_world(self):
        return "Hello, World!"

    def get_next_gen_finite_grid(self):
        next_gen = []
        for y in range(self.grid_size):
            next_gen.append([])
            for x in range(self.grid_size):
                next_gen[y].append(self.get_next_state_of(x, y))
        return next_gen

    def get_next_gen_infinite_grid(self):
        pass
    
    def reset(self):
        pass

    def get_neighbors_of(self, x, y):
        startX = x - 1 if x - 1 >= 0 else x
        startY = y - 1 if y - 1 >= 0 else y
        endX = x + 1 if x + 1 < self.grid_size else x
        endY = y + 1 if y + 1 < self.grid_size else y
        neighbors = []
        for ny in range(startY, endY + 1):
            for nx in range(startX, endX + 1):
                neighbors.append((nx, ny))
        neighbors.remove((x, y))
        return neighbors

    def get_live_neighbor_count_of(self, x, y):
        neighbors = self.get_neighbors_of(x, y)
        count = 0
        for neighbor in neighbors:
            if self.grid[neighbor[1]][neighbor[0]] == 1:
                count += 1
        return count

    def get_next_state_of(self, x, y):
        neighbor_count = self.get_live_neighbor_count_of(x, y)
        state = self.grid[y][x]
        if state == 1 and 2 <= neighbor_count <= 3:
            return 1
        elif state == 0 and neighbor_count == 3:
            return 1
        return 0
