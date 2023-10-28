void pickGradient(){
  if (wait_time == 0) {
    int index_start = (int)random(0,4);
    int index_end = (int)random(0,4);
    int index_start2 = (int)random(0,4);
    int index_end2 = (int)random(0,4);
    color from = gradient_array[index_start];
    color to = gradient_array[index_end];
    color from2 = gradient_array[index_start2];
    color to2 = gradient_array[index_end2];
    new_inter1 = lerpColor(from, to, random(0,1));
    new_inter2 = lerpColor(from2, to2, random(0,1));
    wait_time = fade_interval;
  }
  else {
    wait_time -= 1;
  }
  fade();
  //setGradient(0, 0, width, height/1.35, inter1, inter2, Y_AXIS);
}

void fade(){
  if (fade_amount < 1) {
    fade_amount += 1 / (float) fade_interval;
    color fade_inter1 = lerpColor(inter1, new_inter1, fade_amount);
    color fade_inter2 = lerpColor(inter2, new_inter2, fade_amount);
    setGradient(0, 0, width, height/1.15, fade_inter1, fade_inter2, Y_AXIS);
  }
  else {
    fade_amount = 0;
    inter1 = new_inter1;
    inter2 = new_inter2;
    setGradient(0, 0, width, height/1.15, inter1, inter2, Y_AXIS);
  }
}

void bottomGradient(){
 setGradient(0, (int) (height/1.35), width, height/1.15, 0, 0, Y_AXIS); 
}

void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {

  noFill();

  if (axis == Y_AXIS) {  // Top to bottom gradient
    for (int i = y; i <= y+h; i++) {
      float inter = map(i, y, y+h, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(x, i, x+w, i);
    }
  }  
  else if (axis == X_AXIS) {  // Left to right gradient
    for (int i = x; i <= x+w; i++) {
      float inter = map(i, x, x+w, 0, 1);
      color c = lerpColor(c1, c2, inter);
      stroke(c);
      line(i, y, i, y+h);
    }
  }
}
