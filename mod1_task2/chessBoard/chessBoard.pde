
board myBoard;
FloatDict pieceSizeDict;
IntDict colDict;
IntDict rowDict;
int currentMove = 0;
int xLine;
int yLine;
int stepx;
int stepy;
boolean firstPlot = false;

void setup() {
  fullScreen();
  frameRate(3);
  noStroke();
  background(220, 196, 142);
  
  myBoard = new board();
  pieceSizeDict = new FloatDict();
  pieceSizeDict.set("p", 0.5);
  pieceSizeDict.set("N", 0.7);
  pieceSizeDict.set("B", 0.7);
  pieceSizeDict.set("R", 0.8);
  pieceSizeDict.set("Q", 0.9);
  pieceSizeDict.set("K", 1.0);
  
  colDict = new IntDict();
  colDict.set("a", 0);
  colDict.set("b", 1);
  colDict.set("c", 2);
  colDict.set("d", 3);
  colDict.set("e", 4);
  colDict.set("f", 5);
  colDict.set("g", 6);
  colDict.set("h", 7);
  
  rowDict = new IntDict();
  rowDict.set("1", 7);
  rowDict.set("2", 6);
  rowDict.set("3", 5);
  rowDict.set("4", 4);
  rowDict.set("5", 3);
  rowDict.set("6", 2);
  rowDict.set("7", 1);
  rowDict.set("8", 0);
}

void draw() {
  
  color white = color(255, 255, 255);
  color black = color(0, 0, 0);
  
  move w1 = new move("e", "2", "e", "4", "p", white); //e4
  move b1 = new move("e", "7", "e", "5", "p", black); //e5

  move w2 = new move("f", "2", "f", "4", "p", white); //f4
  move b2 = new move("f", "8", "c", "5", "B", black); //Bc5
  
  move w3 = new move("g", "1", "f", "3", "N", white); //Nf3
  move b3 = new move("d", "7", "d", "6", "p", black); //d8
  
  move w4 = new move("b", "1", "c", "3", "N", white); //Nc3
  move b4 = new move("g", "8", "f", "6", "N", black); //b5
  
  move w5 = new move("f", "1", "c", "4", "B", white); //Bc4
  move b5 = new move("b", "8", "c", "6", "N", black); //Nc6

  move w6 = new move("d", "2", "d", "3", "p", white); //d3
  move b6 = new move("c", "8", "g", "4", "B", black); //Bg4
  
  move w7 = new move("c", "3", "a", "4", "N", white); //Na4
  move b7 = new move("e", "5", "f", "4", "p", black); //exf4
  
  move w8 = new move("a", "4", "c", "5", "N", white); //Nxc5
  move b8 = new move("d", "6", "c", "5", "p", black); //dxc5
  
  move w9 = new move("c", "1", "f", "4", "B", white); //Bxf4
  move b9 = new move("f", "6", "h", "5", "N", black); //Nh5

  move w10 = new move("f", "4", "e", "3", "B", white); //Be3
  move b10 = new move("c", "6", "e", "5", "N", black); //Ne5
  
  move w11 = new move("f", "3", "e", "5", "N", white); //Nxe5
  move b11 = new move("g", "4", "d", "1", "B", black); //Bxd1
  
  move w12 = new move("c", "4", "f", "7", "B", white); //Bxf7
  move b12 = new move("e", "8", "e", "7", "K", black); //Ke7
  
  move w13 = new move("e", "3", "c", "5", "B", white); //Bxc5
  move b13 = new move("e", "7", "f", "6", "K", black); //Kf6

  move w14 = new move("e", "1", "g", "1", "K", white); //0-0
  move w14b = new move("h", "1", "f", "1", "R", white); //0-0
  move b14 = new move("f", "6", "e", "5", "K", black); //Kxe5
  
  move w15 = new move("f", "1", "f", "5", "R", white); //Rf5
  
  game myGame = new game(50);
  
  
  myGame.logMove(w1);
  myGame.logMove(b1);
  myGame.logMove(w2);
  myGame.logMove(b2);
  myGame.logMove(w3);
  myGame.logMove(b3);
  myGame.logMove(w4);
  myGame.logMove(b4);
  myGame.logMove(w5);
  myGame.logMove(b5);
  myGame.logMove(w6);
  myGame.logMove(b6);
  myGame.logMove(w7);
  myGame.logMove(b7);
  myGame.logMove(w8);
  myGame.logMove(b8);
  myGame.logMove(w9);
  myGame.logMove(b9);
  myGame.logMove(w10);
  myGame.logMove(b10);
  myGame.logMove(w11);
  myGame.logMove(b11);
  myGame.logMove(w12);
  myGame.logMove(b12);
  myGame.logMove(w13);
  myGame.logMove(b13);
  myGame.logMove(w14);
  myGame.logMove(w14b);
  myGame.logMove(b14);
  myGame.logMove(w15);
  
  if (currentMove == 0) {
    //drawBoard();
  }
  myGame.playMove();
  
  
}

void drawBoard() {
  int board_length = myBoard.getBoardLength();
  int width_offset = myBoard.getWidthOffset();
  int height_offset = myBoard.getHeightOffset();
  
  for (int i = 0; i < 8; i = i+1) {
    for (int j = 0; j < 8; j = j+1) {
      if (j%2 == i%2) {
        fill(220, 196, 142); // light squares
      }
      else {
        fill(110, 38, 14); // dark squares
      }
      
      rect((board_length/8)*j + width_offset,
      (board_length/8)*i + height_offset, board_length/8, board_length/8);
    }
  }
}
