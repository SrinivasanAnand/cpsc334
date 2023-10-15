
void move_joystick(bar b, bar b2) {
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
      print(input);
      
      String y_val_string = "";
      int y_val_len = 0;
      for(int i = 0; i < 5; i++) {
        if (input.charAt(i) == '|') {
          break;
        }
        else {
          y_val_string += input.charAt(i);
          y_val_len += 1;
        }
      }
      
      //int x_val = int(input.substring(4,8));
      int y_val = int(y_val_string);
      int switch_val = int(input.charAt(y_val_len + 1)) - 48;
      int button_val = int(input.charAt(y_val_len + 3)) - 48;

      println(switch_val);
      println(button_val);
      
      float zeroed_y_val = y_val - 2043;
      float my_move;
      if (zeroed_y_val < 0) {
        my_move = zeroed_y_val / 1000;
        
      }
      else {
        my_move = zeroed_y_val / 350;
      }
      
      if (switch_val == 0) {
        if (button_val == 0) {
          charges[0] = false;
          charges[1] = false;
        }
        else {
          charges[0] = true;
          charges[1] = false;
        }
        b.move(my_move, 1);
      }
      else {
        if (button_val == 0) {
          charges[0] = false;
          charges[1] = false;
        }
        else {
          charges[0] = false;
          charges[1] = true;
        }
        b2.move(my_move, 1);
      }
      
      
    }
  }
}
