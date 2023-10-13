
void move_joystick(bar b) {
  int lf = 10;
  // Expand array size to the number of bytes you expect:
  
  while (myPort.available() > 0){
    byte[] inBuffer = new byte[50];
    boolean flag = false;
    myPort.readBytesUntil(lf, inBuffer);
    
    for (int i = 0; i < 25; i++) {
      if (inBuffer[i] != 0) {
        flag = true;
      }
    }
    
    if (flag == true) {
      String input = new String(inBuffer);
      //int x_val = int(input.substring(4,8));
      int y_val = int(input.substring(14,18));
      
      float zeroed_y_val = y_val - 2043; 
      if (zeroed_y_val < 0) {
        float my_move = zeroed_y_val / 1000;
        b.move(my_move, 1);
      }
      else {
        float my_move = zeroed_y_val / 350;
        b.move(my_move, 1);
      }
    }
  }
}
