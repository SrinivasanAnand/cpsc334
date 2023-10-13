
void move_joystick(bar b) {
  int lf = 10;
  // Expand array size to the number of bytes you expect:
  
  while (myPort.available() > 0){
    byte[] inBuffer = new byte[50];
    boolean flag = false;
    int count = 1;
    myPort.readBytesUntil(lf, inBuffer);
    
    for (int i = 0; i < 50; i++) {
      if (inBuffer[i] != 0) {
         count -= 1;
         if (count == 0) {
            flag = true;
         }
      }
    }
    
    if (flag == true) {
      String input = new String(inBuffer);
      //println(input);
      //int x_val = int(input.substring(4,8));
      int y_val = int(input.substring(14,18));
     
      float zeroed_y_val = y_val - 3060;

      if (zeroed_y_val == -3060) {
        println("no val found for " + int(input.substring(14,18)));
      }
      if (zeroed_y_val < 50 && zeroed_y_val > -50) {}
      else if (zeroed_y_val < 0) {
        println(zeroed_y_val);
        float my_move = zeroed_y_val / 1000;
        b.move(my_move, 1);
      }
      else {
        println(zeroed_y_val);
        float my_move = zeroed_y_val / 350;
        b.move(my_move, 1);
      }
    }
  }
}
