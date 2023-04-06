#!/usr/bin/env python3

class Game:

    def __init__(self, live_cells=[]):
        self.live_cells = live_cells

    def hello_world(self):
        return "Hello, World!"

    def get_next_gen_finite_grid(self):
        pass

    def get_next_gen_infinite_grid(self):
        return self.get_next_gen()
    
    def reset(self):
        self.live_cells = []
    
    def get_neighbors_of(self, x, y):
        neighbors = []
        for nY in range(y - 1, y + 2):
            for nX in range(x - 1, x + 2):
                neighbors.append((nX, nY))
        neighbors.remove((x, y))
        return neighbors

    def get_live_neighbor_count_of(self, x, y):
        neighbors = self.get_neighbors_of(x, y)
        count = 0
        for neighbor in neighbors:
            if neighbor in self.live_cells:
                count += 1
        return count

    def get_next_state_of(self, x, y):
        neighbor_count = self.get_live_neighbor_count_of(x, y)
        if (x, y) in self.live_cells and 2 <= neighbor_count <= 3:
            return True
        elif (x, y) not in self.live_cells and neighbor_count == 3:
            return True
        return False
    
    def get_cells_to_check(self):
        cells_to_check = []
        for live_cell in self.live_cells:
            cells_to_check.append(live_cell)
            cells_to_check.extend(self.get_neighbors_of(live_cell[0], live_cell[1]))
        return list(set(cells_to_check))
    
    def get_next_gen(self):
        next_gen = []
        for cell_to_check in self.get_cells_to_check():
            if self.get_next_state_of(cell_to_check[0], cell_to_check[1]):
                next_gen.append(cell_to_check)
        return next_gen
