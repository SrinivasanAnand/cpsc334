
void updateBallPos(){
  // updates ball position based on velocity
  ball_pos_last.x = ball_pos.copy().x;
  ball_pos_last.y = ball_pos.copy().y;
  ball_pos.add(ball_vel);
  if (ball_vel.mag() > speed){
    ball_vel.x = ball_vel.x - friction;
    ball_vel.y = ball_vel.y - friction;
  }
  ball_pos_last.x -= 1;
}

void resetBallPos() {
  // resets ball position to center of screen
  ball_pos.x = (edgex + edgex_end) / 2;
  ball_pos.y = (edgey + edgey_end) / 2;
  ball_pos_last.x = ball_pos.x;
  ball_pos_last.y = ball_pos.y;
  ball_vel = PVector.random2D();
  ball_vel.mult(speed);
  delay(1000);
  reset = true;
}
