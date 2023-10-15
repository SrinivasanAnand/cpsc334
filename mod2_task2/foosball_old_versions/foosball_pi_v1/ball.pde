

void updateBallPos(){
  ball_pos_last = ball_pos;
  ball_pos.add(ball_vel);
  if (ball_vel.mag() > speed){
    ball_vel.x = ball_vel.x - friction;
    ball_vel.y = ball_vel.y - friction;
  }
}

void resetBallPos() {
  ball_pos.x = (edgex + edgex_end) / 2;
  ball_pos.y = (edgey + edgey_end) / 2;
  ball_pos_last = ball_pos;
  ball_vel = PVector.random2D();
  ball_vel.mult(speed);
  delay(1000);
  reset = true;
}
