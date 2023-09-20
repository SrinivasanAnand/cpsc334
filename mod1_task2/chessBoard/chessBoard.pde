
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

void plot(int x1, int y1, color c, float size) {
  
  int board_length = myBoard.getBoardLength(); 
  int[] square = myBoard.getSquareCoordinates(x1, y1);

  fill(c, 100);
  ellipse(square[0], square[1], board_length/(8/size), board_length/(8/size));
  
  
}

public class board {
  
  int board_length, width_offset, height_offset, width_center_offset, height_center_offset;
  
  board() {
    
    if (width > height) {
      this.board_length = height;
      this.width_offset = (width - height) / 2;
      this.height_offset = 0;
      
    }
    
    else {
      this.board_length = width;
      this.width_offset = (board_length/16);
      this.height_offset = (height - width) / 2;
    }
    this.width_center_offset = this.width_offset + (this.board_length/16);
    this.height_center_offset = this.height_offset + (this.board_length/16);
  }
  
  int[] getSquareCoordinates(int x, int y){
    int[] coord = new int[2];
    coord[0] = (this.board_length / 8)*x + this.width_center_offset;
    coord[1] = (this.board_length / 8)*y + this.height_center_offset;
    return coord;
  }
  
  public int getBoardLength(){
    return board_length;
  }
  public int getWidthOffset(){
    return width_offset;
  }
  public int getHeightOffset(){
    return height_offset;
  }
  public int getWidthCenterOffset(){
    return width_center_offset;
  }
  public int getHeightCenterOffset(){
    return height_center_offset;
  }
}

public class move {
  int x1, y1, x2, y2;
  String piece;
  color c;
  
  move(String x1, String y1, String x2, String y2, String piece, color c) {
    this.x1 = colDict.get(x1);
    this.y1 = rowDict.get(y1);
    this.x2 = colDict.get(x2);
    this.y2 = rowDict.get(y2);
    this.piece = piece;
    this.c = c;
  }
  
  public int getX1(){
    return x1;
  }
  public int getX2(){
    return x2;
  }
  public int getY1(){
    return y1;
  }
  public int getY2(){
    return y2;
  }
  public String getPiece(){
    return piece;
  }
  public color getColor(){
    return c;
  }
}

public class game {
  move[] moves;
  int size;
  int pos;
  
  game(int size) {
    this.size = size;
    this.pos = 0;
    this.moves = new move[size];
  }
  
  void logMove(move m) {
    moves[pos] = m;
    pos = pos + 1;
  }
  
  void playMove() {
    
    if (currentMove >= pos) {
      return;
    }
    
    move m = moves[currentMove];
    
    plot(m.x1, m.y1, m.c, pieceSizeDict.get(m.piece));
    
  
    int[] square1 = myBoard.getSquareCoordinates(m.x1, m.y1);
    int[] square2 = myBoard.getSquareCoordinates(m.x2, m.y2); 
    
    
    stroke(m.c, 125);
    strokeWeight(5);
    line(square1[0], square1[1], square2[0], square2[1]);
    noStroke();
    
    currentMove = currentMove + 1;
    
    plot(m.x2, m.y2, m.c, pieceSizeDict.get(m.piece));
  }
  
  void animateMove() {
    
    if (currentMove >= pos) {
      return;
    }
    
    move m = moves[currentMove];
    
    int[] square1 = myBoard.getSquareCoordinates(m.x1, m.y1);
    int[] square2 = myBoard.getSquareCoordinates(m.x2, m.y2);
    
    if (firstPlot == false) {
      plot(m.x1, m.y1, m.c, pieceSizeDict.get(m.piece));
      xLine = square1[0];
      yLine = square1[1];
      stepx = (square2[0] - square1[0]) / 20;
      stepy = (square2[1] - square1[1]) / 20;
      firstPlot = true;
    }
    
    if (abs(xLine - square2[0]) > 10 || abs(yLine - square2[1]) > 10) {
      stroke(m.c, 125);
      strokeWeight(5);
      if (abs(xLine - square2[0]) > 3) {
        xLine = xLine + stepx;
      }
      if (abs(yLine - square2[1]) > 3) {
        yLine = yLine + stepy;
      }
      line(square1[0], square1[1], xLine, yLine);
      noStroke();
    }
    else {
      plot(m.x2, m.y2, m.c, pieceSizeDict.get(m.piece));
      currentMove = currentMove + 1;    
      firstPlot = false;
    }
  }
  
  void playGame() {
    for (int i = 0; i < this.pos; i = i + 1) {
       this.playMove();
    }
  }
  
}
