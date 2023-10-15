
void makeBoard(int goal_length, color board_color, color goal_color) {
  // draws foosball board
  
  fill(board_color);
  rect(edgex, edgey, edgex_end, edgey_end);
  
  int y_center = (edgey + edgey_end) / 2; 
  int half_goal = goal_length / 2;
  
  // draw goal
  noFill();
  stroke(goal_color);
  rect(edgex, y_center + half_goal, edgex - width/20, y_center - half_goal);
  rect(edgex_end, y_center + half_goal, edgex_end + width/20, y_center - half_goal);
  stroke(board_color);
  line(edgex, y_center + half_goal, edgex, y_center - half_goal);
  line(edgex_end, y_center + half_goal, edgex_end, y_center - half_goal);
  noStroke();
}

void displayScore() {
  // displays score
  
  textSize(75);
  textAlign(CENTER);
  String myScore = str(scores[0]);
  String oppScore = str(scores[1]);
  text(myScore + "-" + oppScore, width/2, 90);
}

void updateScore() {
  // updates score
  
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

void checkEnd(color my_color, color opp_color) {
  if (scores[0] == winning_score){
    gameover = true;
    textSize(100);
    textAlign(CENTER);
    fill(my_color);
    text("You Win!", width/2, height/2);
    ball_vel.x = 0;
    ball_vel.y = 0;
    end_wait -= 1;
    if (end_wait == 0) {
     
     exit(); 
    }
  }
  if (scores[1] == winning_score){
    gameover = true;
    textSize(100);
    textAlign(CENTER);
    fill(opp_color);
    text("You Lose!", width/2, height/2);
    ball_vel.x = 0;
    ball_vel.y = 0;
    end_wait -= 1;
    if (end_wait == 0) {
     exit(); 
    }
  }
}
