<h1>Generative Art</h1>

Link to video: https://youtu.be/oqQe_3LBvek

This generative art program provides a way of visualizing patterns and geometry of a game of chess. 

Chess is considered a beautiful game for many reasons, one of which being its symmetry, geometry and patterns of movement.
This work aims to expose these patterns of movement in a clear manner, such that even someone who does not know how to play
chess can appreciate the design and flow of a chess game. In fact, the work intentionally separates the patterns of movement
from the strategic aspect of the game (removing major visual queues that would normally indicate types of pieces).

The program draws moves from a single chess game in sequence. The specific game from which the moves in the work are taken
from is Alexander Alekhine vs Oscar Tenner (1911).

The artwork deals with dimensions and space in two major ways. First, the program determines the length of the virtual
(non-visible) chess board (and the squares within it) based on the height and width of the screen. A board length is
always picked such that a full square board can fit within the screen. 

Another detail influenced by the dimension of the screen is the size of the pieces. Regardless of the size of the screen,
the pieces are displayed from smallest to biggest as following: pawn, knight & bishop, rook, queen, king. For smaller screens,
the relative size of the pieces increases across the board, such that the pieces don’t get so small that they get lost in the canvas.

Note: runninig on Boot is accomplished through a .desktop file in ~/.config/autostart.

