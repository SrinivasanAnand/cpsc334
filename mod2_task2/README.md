<h1>Foosball Game</h1>

Link to video: https://www.youtube.com/watch?v=35P8G-dKYxA

My goal for this project was to recreate the feeling of playing foosball with a virtual game.
As such, the gameplay for my project (described in more detail below) highly resembles the gameplay of foosball.
I tried to capture the tactile element of turning the handles with the use of a joystick and
switch for control over the virtual rods. A button which virtually “charges” a selected rod results
in the ball increasing its velocity when making contact with this rod. This behavior is meant to mimic the feeling of spinning a
foosball rod to give the ball a high speed.

Overall, the work aims to adapt the game of foosball to a virtual setting in order to achieve a similar tactile and emotional feeling.
A virtual version of foosball allows for greater portability and allows for a single person to play and enjoy a game similar
to foosball (which might prove useful when friends are busy). Moreover, the game could easily be adapted to include a multiplayer
mode simply by building a second controller and making minimal changes to the codebase.

The game is played using a controller with a joystick, a switch, and a button. The mechanics of the gameplay are as follows:
- The **switch** chooses which rod is selected. If the switch points leftwards, the leftmost rod is selected. If the switch points rightwards, the rightmost rod is selected.
- The **joystick** is used to control the position of the rod that is selected. That is, moving the joystick up or down moves the rod upwards or downwards as appropriate.
- Pressing the **button** “charges” whichever rod is selected. A charged rod has a thin yellow outline and when charged, a rod increases the ball's velocity if it makes contact with it.
