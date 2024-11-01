# :diamond_shape_with_a_dot_inside: Tak Game (4x4 Version)

Tak is a two-player game played on a 4x4 board, where each player has 20 pieces. This repository contains a simplified 4x4 version of the two-player game Tak, implemented in Prolog.

## How to Play

At the start, the board is empty. During their turn, each player can perform one of the following moves:

1. **Place a piece:** Place a piece of their color on any empty cell.
2. **Stack a piece:** Place a piece of their color on top of an existing stack of pieces in any occupied cell.
3. **Move a stack:** Choose a cell with a stack of pieces, where the top piece is their color, and move that stack (while maintaining the order of pieces) to neighboring cells.

For more information about the game and its complete rules, please refer to [this link](https://www.youtube.com/watch?v=iEXkpS-Q9dI).

## Objective
The objective is to create a path with pieces of the player’s color connecting two opposite edges of the board.

## Additional Rules

* Each cell can hold a maximum of 8 pieces.
* Moves are only allowed to adjacent cells that share an edge with the cell containing the player’s top piece.
* If both players run out of pieces, the game ends in a draw.

## Contributing

Feel free to submit issues or pull requests if you find bugs or want to improve the game.

## License

This project is open-source and available under the [MIT License](LICENSE).
