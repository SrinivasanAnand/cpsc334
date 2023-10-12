
void updateBoardReflection(int edgex, int edgey, int goal_length) {
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
  if ((ball_pos.x + r >= x2 && ball_pos.x - r <= x1) && (ball_pos.y >= y2 && ball_pos.y <= y1)) {
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

void addCharge(boolean charged) {
  if (charged && ball_vel.mag() < 10) {
    ball_vel.x += charge_add * ball_vel.x;
    ball_vel.y += charge_add * ball_vel.y;
  }
}
