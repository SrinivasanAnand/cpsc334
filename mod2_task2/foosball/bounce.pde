
void updateBoardReflection(int edgex, int edgey, int goal_length) {
  // reflects bounce / reflects velocity if ball touches board edegs
  
  int y_center = (edgey + edgey_end) / 2; 
  int half_goal = goal_length / 2;
  
  if (ball_pos.x < edgex + r) {
    if ((ball_pos.y - r > y_center - half_goal) && 
    (ball_pos.y + r < y_center + half_goal)){
      //computer scored
      if (scored == false) {
        scored = true;
        scores[1] += 1;
      }
    }
    else {
      ball_pos.x = edgex + r;
      ball_vel.x *= -1;
    }
  }
  
  if (ball_pos.x > width - edgex - r) {
    if ((ball_pos.y - r > y_center - half_goal) && 
    (ball_pos.y + r < y_center + half_goal)){
      //player scored
      if (scored == false) {
        scored = true;
        scores[0] += 1;
      }
    }
    else {
      ball_pos.x = width - edgex - r;
      ball_vel.x *= -1;
    }
  }
  
  if (ball_pos.y < edgey + r) {
    ball_pos.y = edgey + r;
    ball_vel.y *= -1;
  }
  
  if (ball_pos.y > height - edgey - r) {
    ball_pos.y = height - edgey - r;
    ball_vel.y *= -1;
  }
}

void updateBoxReflection(int x1, float y1, int x2, float y2, boolean charged){
  // reflects bounce / reflects velocity if ball touches box with
  // lower right corner at (x1, y1) and upper left corner at (x2, y2)
  // if charged, reflection also increases velocity by charge_add
  if ((ball_pos.x + r >= x2 && ball_pos.x - r <= x1) && (ball_pos.y >= y2 && ball_pos.y <= y1) &&
  (ball_pos.y + r >= y2 && ball_pos.y - r <= y1) && (ball_pos.x >= x2 && ball_pos.x <= x1)) {
    innerBounce(x1, y1, x2, y2, charged);
  }
  else if ((ball_pos.x + r >= x2 && ball_pos.x - r <= x1) && (ball_pos.y >= y2 && ball_pos.y <= y1)) {
    // ball hit left or right surface of box
    // need to reset ball_pos
    ball_vel.x *= -1;
    ball_pos = ball_pos_last;
    addCharge(charged);
  }
  else if ((ball_pos.y + r >= y2 && ball_pos.y - r <= y1) && (ball_pos.x >= x2 && ball_pos.x <= x1)){
    // ball hit top or bottom surface of box
    ball_vel.y *= -1;
    ball_pos = ball_pos_last;
    addCharge(charged);
  }
  else if ((ball_pos.x + r >= x2 && ball_pos.x - r <= x1) && (ball_pos.y + r >= y2 && ball_pos.y - r <= y1)) {
    // ball hit corner of box
    
    if ((ball_pos.x >= x1 && ball_pos.y >= y1) || (ball_pos.x <= x2 && ball_pos.y <= y2)) {
      float temp = ball_vel.x;
      ball_vel.x = -ball_vel.y;
      ball_vel.y = -temp;
      ball_pos = ball_pos_last;
      addCharge(charged);
    }
    else {
      float temp = ball_vel.x;
      ball_vel.x = ball_vel.y;
      ball_vel.y = temp;
      ball_pos = ball_pos_last;
      addCharge(charged);
    } 
  }
  else if ((ball_pos.x <= x1 && ball_pos.x >= x2) &&
  (ball_pos.y <= y1 && ball_pos.y >= y2)) {
    ball_pos = ball_pos_last;
  }
  
  
}

void innerBounce(int x1, float y1, int x2, float y2, boolean charged){
 float last_pos_x = ball_pos.x - ball_vel.x;
 float last_pos_y = ball_pos.y - ball_vel.y;
 
 if (ball_pos.x > last_pos_x && x2 >= last_pos_x) {
   float x_frac = (x2 - last_pos_x) / (ball_pos.x - last_pos_x);
   float y_hit = (ball_pos.y - last_pos_y) * x_frac + last_pos_y;
   if (y_hit > y2 && y_hit < y1) {
     // hit left side
     ball_vel.x *= -1;
     ball_pos = ball_pos_last;
     addCharge(charged);
   }
 }
 if (ball_pos.x < last_pos_x && x1 <= last_pos_x) {
   float x_frac = (x1 - last_pos_x) / (ball_pos.x - last_pos_x);
   float y_hit = (ball_pos.y - last_pos_y) * x_frac + last_pos_y;
   if (y_hit > y2 && y_hit < y1) {
     // hit right side
     ball_vel.x *= -1;
     ball_pos = ball_pos_last;
     addCharge(charged);
   }
 }
 if (ball_pos.y > last_pos_y && y2 >= last_pos_y) {
   float y_frac = (y2 - last_pos_y) / (ball_pos.y - last_pos_y);
   float x_hit = (ball_pos.x - last_pos_x) * y_frac + last_pos_x;
   if (x_hit > x2 && x_hit < x1) {
     // hit top
     ball_vel.y *= -1;
     ball_pos = ball_pos_last;
     addCharge(charged);
   }
 }
 if (ball_pos.y < last_pos_y && y1 <= last_pos_y) {
   float y_frac = (y1 - last_pos_y) / (ball_pos.y - last_pos_y);
   float x_hit = (ball_pos.x - last_pos_x) * y_frac + last_pos_x;
   if (x_hit > x2 && x_hit < x1) {
     // hit right side
     ball_vel.y *= -1;
     ball_pos = ball_pos_last;
     addCharge(charged);
   }
 }
}

void addCharge(boolean charged) {
  if (charged && ball_vel.mag() < speed + 5) {
    ball_vel.x += charge_add * ball_vel.x;
    ball_vel.y += charge_add * ball_vel.y;
  }
}
