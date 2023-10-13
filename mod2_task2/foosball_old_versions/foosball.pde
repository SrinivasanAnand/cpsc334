import processing.serial.*;

Serial myPort;

// board dimensions
int edgex = 100; // x-coord of top left corner of board
int edgey = 100; // y-coord of top left corner of board
int edgex_end;
int edgey_end;
int goal_length;

// ball specifics
PVector ball_pos;
PVector ball_vel;
PVector ball_pos_last;
float r = 6;
float speed = 7.5;
float charge_add = 0.25;
float friction = 0.2;


PVector bar_pos;
PVector bar_vel;
int bar_size = 10;

float[] y_offsets = new float[4];
boolean[] charges = new boolean[4];

int opp_count;
float opp_move;
float opp_move2;

boolean scored;
int score_wait;
int[] scores = new int[2];

boolean reset;

boolean button;
boolean switch_button;

void setup() {
  size(640, 360);
  frameRate(25);
  noStroke(); 
  ellipseMode(RADIUS);
  rectMode(CORNERS);
  
  myPort = new Serial(this, Serial.list()[2], 9600);
  
  ball_pos = new PVector(edgex+r, edgey+r);
  ball_pos_last = ball_pos;
  ball_vel = PVector.random2D();
  ball_vel.mult(speed);
  
  edgex_end = width-edgex;
  edgey_end = height-edgey;
  goal_length = 50;
  
  charges[2] = false;
  charges[3] = false;
  
  score_wait = 5;

}


void draw() { 
  background(51);

  makeBoard(goal_length, 76);
  
  color bar_color = color(255);
  color opp_box_color = color(230, 200, 80);
  color my_box_color = color(137, 207, 240);
  
  fill(255);
  ellipse(ball_pos.x, ball_pos.y, r, r);
  updateBallPos();
  
  bar myBar = new bar(100, 25, 25, 3, 15, bar_color, my_box_color, 0);
  bar myBar2 = new bar(275, 25, 25, 2, 30, bar_color, my_box_color, 1);
  myBar.updateBounce();
  myBar2.updateBounce();

  
  bar oppBar = new bar(200, 25, 25, 2, 30, bar_color, opp_box_color, 2);
  bar oppBar2 = new bar(375, 25, 25, 3, 15, bar_color, opp_box_color, 3);
  oppBar.updateBounce();
  oppBar2.updateBounce();

  if (opp_count == 0) {
    opp_move = random(-3,3);
    opp_move2 = random(-3,3);
    opp_count = 10;
  }
  else {
    oppBar.move(opp_move, 2);
    oppBar2.move(opp_move2, 2);
    opp_count -= 1;
  }
 
  if (keyPressed) {
    if (key == 's' || key == 'S') {
      switch_button = true;
    }
  }
  else {
      switch_button = false;
  }
  
  if (keyPressed) {
    if (key == 'b' || key == 'B') {
      button = true;
    }
  }
  else {
      button = false;
  }
  
  if (keyPressed) {
    if (key == 'r' || key == 'R') {
      resetBallPos();
    }
  }
  
  if (switch_button) {
    if (button) {
      charges[0] = false;
      charges[1] = true;
    }
    else {
      charges[0] = false;
      charges[1] = false;
    }
    move_joystick(myBar2);
  }
  else {
    if (button) {
      charges[0] = true;
      charges[1] = false;
    }
    else {
      charges[0] = false;
      charges[1] = false;
    }
    move_joystick(myBar);
  }

  
  
  fill(255);
  updateBoardReflection(edgex, edgey, goal_length);
  updateScore();
  displayScore();
  
}
