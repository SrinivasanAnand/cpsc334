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
