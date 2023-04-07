#!/usr/bin/env python3

# IMPORTS
from ..game.game import Game

class TestGame:

    def test_hello_world(self):
        game = Game()
        assert game.hello_world() == "Hello, World!"
    
    def test_get_neighbors(self):
        game = Game(3)

        neighbors00 = game.get_neighbors_of(0, 0)
        assert 3 == len(neighbors00)
        assert (0, 1) in neighbors00
        assert (1, 1) in neighbors00
        assert (1, 0) in neighbors00

        neighbors01 = game.get_neighbors_of(0, 1)
        assert 5 == len(neighbors01)
        assert (0, 0) in neighbors01
        assert (1, 0) in neighbors01
        assert (1, 1) in neighbors01
        assert (0, 2) in neighbors01
        assert (1, 2) in neighbors01

        neighbors11 = game.get_neighbors_of(1, 1)
        assert 8 == len(neighbors11)
        assert (0, 0) in neighbors11
        assert (0, 1) in neighbors11
        assert (0, 2) in neighbors11
        assert (1, 0) in neighbors11
        assert (1, 2) in neighbors11
        assert (2, 0) in neighbors11
        assert (2, 1) in neighbors11
        assert (2, 2) in neighbors11
    
    def test_get_live_neighbor_count(self):
        game = Game(3)
        game.grid[0][1] = 1
        game.grid[1][1] = 1
        game.grid[2][1] = 1

        assert game.get_live_neighbor_count_of(0, 0) == 2
        assert game.get_live_neighbor_count_of(0, 1) == 3
        assert game.get_live_neighbor_count_of(1, 0) == 1
        assert game.get_live_neighbor_count_of(1, 1) == 2
    
    def test_get_next_state(self):
        game = Game(3)
        game.grid[0][1] = 1
        game.grid[1][1] = 1
        game.grid[2][1] = 1

        assert game.get_next_state_of(0, 0) == 0
        assert game.get_next_state_of(0, 1) == 1
        assert game.get_next_state_of(1, 0) == 0
        assert game.get_next_state_of(1, 1) == 1

    def test_get_next_gen_finite_grid(self):
        game = Game(3)
        game.grid[0][1] = 1
        game.grid[1][1] = 1
        game.grid[2][1] = 1

        expected_next_gen = [
            [0, 0, 0],
            [1, 1, 1],
            [0, 0, 0]
        ]

        assert game.get_next_gen_finite_grid() == expected_next_gen

