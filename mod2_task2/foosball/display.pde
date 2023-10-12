
void makeBoard(int goal_length, color board_color) {
  // draws foosball board
  
  fill(board_color);
  rect(edgex, edgey, edgex_end, edgey_end);
  
  int y_center = (edgey + edgey_end) / 2; 
  int half_goal = goal_length / 2;
  
  noFill();
  stroke(255);
  rect(edgex, y_center + half_goal, edgex - 30, y_center - half_goal);
  rect(edgex_end, y_center + half_goal, edgex_end + 30, y_center - half_goal);
  stroke(76);
  line(edgex, y_center + half_goal, edgex, y_center - half_goal);
  line(edgex_end, y_center + half_goal, edgex_end, y_center - half_goal);
  noStroke();
}

void displayScore() {
  textSize(75);
  textAlign(CENTER);
  String myScore = str(scores[0]);
  String oppScore = str(scores[1]);
  text(myScore + "-" + oppScore, width/2, 90);
}

void updateScore() {
  if (scored == true) {
    score_wait -= 1;
    if (score_wait == 0) {
      ball_vel.x = 0;
      ball_vel.y = 0;
      scored = false;
      score_wait = 5;
      resetBallPos();
      
    }
    
  }
}
