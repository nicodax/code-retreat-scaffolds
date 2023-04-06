#!/usr/bin/env python3

# IMPORTS
from ..game.game import Game

class TestGame:

    def test_hello_world(self):
        game = Game()
        assert game.hello_world() == "Hello, World!"
    
    def test_get_neighbors(self):
        game = Game()
        neighbors = game.get_neighbors_of(0, 0)
        assert len(neighbors) == 8
        assert (-1, -1) in neighbors
        assert (0, -1) in neighbors
        assert (1, -1) in neighbors
        assert (-1, 0) in neighbors
        assert (1, 0) in neighbors
        assert (-1, 1) in neighbors
        assert (0, 1) in neighbors
        assert (1, 1) in neighbors
    
    def test_get_live_neighbor_count(self):
        game = Game([(1, 0), (1, 1), (1, 2)])
        live_neighbor_count_00 = game.get_live_neighbor_count_of(0, 0)
        live_neighbor_count_01 = game.get_live_neighbor_count_of(0, 1)
        live_neighbor_count_10 = game.get_live_neighbor_count_of(1, 0)
        live_neighbor_count_11 = game.get_live_neighbor_count_of(1, 1)

        assert live_neighbor_count_00 == 2
        assert live_neighbor_count_01 == 3
        assert live_neighbor_count_10 == 1
        assert live_neighbor_count_11 == 2
    
    def test_get_next_state(self):
        game = Game([(1, 0), (1, 1), (1, 2)])
        next_state_00 = game.get_next_state_of(0, 0)
        next_state_01 = game.get_next_state_of(0, 1)
        next_state_10 = game.get_next_state_of(1, 0)
        next_state_11 = game.get_next_state_of(1, 1)

        assert next_state_00 == False
        assert next_state_01 == True
        assert next_state_10 == False
        assert next_state_11 == True

    def test_get_cells_to_check(self):
        game = Game([(0, 1), (1, 1), (2, 1)])
        cells_to_check = game.get_cells_to_check()

        assert len(cells_to_check) == 15

        assert (-1, 0) in cells_to_check
        assert (0, 0) in cells_to_check
        assert (1, 0) in cells_to_check
        assert (2, 0) in cells_to_check
        assert (3, 0) in cells_to_check

        assert (-1, 1) in cells_to_check
        assert (0, 1) in cells_to_check
        assert (1, 1) in cells_to_check
        assert (2, 1) in cells_to_check
        assert (3, 1) in cells_to_check

        assert (-1, 2) in cells_to_check
        assert (0, 2) in cells_to_check
        assert (1, 2) in cells_to_check
        assert (2, 2) in cells_to_check
        assert (3, 2) in cells_to_check

    
    def test_get_next_gen(self):
        game = Game([(1, 0), (1, 1), (1, 2)])
        next_gen = game.get_next_gen()

        assert len(next_gen) == 3
        assert (0, 1) in next_gen
        assert (1, 1) in next_gen
        assert (2, 1) in next_gen
