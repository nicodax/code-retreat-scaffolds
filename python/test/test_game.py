#!/usr/bin/env python3

# IMPORTS
from ..game.game import Game

class TestGame:

    def test_hello_world(self):
        game = Game()
        assert game.hello_world() == "Hello, World!"