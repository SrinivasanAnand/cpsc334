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
float r = 8;

// ball movement
PVector bar_pos;
PVector bar_vel;
float speed = 15;
float friction = 0.2; // only comes into play when ball moving faster than original speed

// box variables
int box_width;
int box_height;
int three_box_spacing;
int two_box_spacing;
//int bar_size = 10;

//offsets for each bar to determine their vertical position
float[] y_offsets = new float[4];
//charges indicate whether each bar is "charged" or not
boolean[] charges = new boolean[4];
float charge_add = 0.25;

//opponent/computer variables
int opp_count;
float opp_move;
float opp_move2;

// score variables
boolean scored;
int score_wait;
int[] scores = new int[2];
int winning_score = 10;
boolean gameover = false;
int end_wait = 25;

boolean reset;

void setup() {
  size(1200, 675);
  //surface.setLocation(2500, 250);
  frameRate(25);
  noStroke(); 
  ellipseMode(RADIUS);
  rectMode(CORNERS);
  
  myPort = new Serial(this, Serial.list()[10], 9600);
  
  edgex_end = width-edgex;
  edgey_end = height-edgey;
  goal_length = (height - 2*edgey) / 3;
  
  // ball start position and velocity
  ball_pos = new PVector((edgex + edgex_end) / 2, (edgey + edgey_end) / 2);
  ball_pos_last = new PVector((edgex + edgex_end) / 2, (edgey + edgey_end) / 2);
  ball_vel = PVector.random2D();
  ball_vel.mult(speed);
  
  // set box dimensions
  box_width = height / 12;
  box_height = height / 12;
  three_box_spacing = height / 12;
  two_box_spacing = height / 8;
  
  // opponent bars start uncharged
  charges[2] = false;
  charges[3] = false;
  
  // wait time after scoring
  score_wait = 5;
}


void draw() { 
  
  color background_color = color(138, 154, 91);
  color board_color = color(234, 221, 202);
  color goal_color = color(255);
  color bar_color = color(112, 128, 144);
  color opp_box_color = color(227, 115, 94);
  color my_box_color = color(111, 143, 175);  
  color ball_color = color(255);
  
  background(background_color);
  makeBoard(goal_length, board_color, goal_color);
  
  fill(ball_color);
  ellipse(ball_pos.x, ball_pos.y, r, r);
  
  
  // create player bars
  int division = 6;
  int board_width = width - 2*edgex;
  
  bar myBar = new bar((board_width / division), box_width, box_height, 3, three_box_spacing, bar_color, my_box_color, 0);
  bar myBar2 = new bar(4 * (board_width / division) - 40, box_width, box_height, 2, two_box_spacing, bar_color, my_box_color, 1);

  // create opponent bars
  bar oppBar = new bar(2 * (board_width / division) + 40, box_width, box_height, 2, two_box_spacing, bar_color, opp_box_color, 2);
  bar oppBar2 = new bar(5 * (board_width / division), box_width, box_height, 3, three_box_spacing, bar_color, opp_box_color, 3);
  
  // move opponent bars at random
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
  
  // get input from joystick, switch, button to move bars
  get_input(myBar, myBar2);

  
  fill(255);
  
  updateBallPos();
  
  // update reflection of board edges
  updateBoardReflection(edgex, edgey, goal_length);
  
  
  
  //update and display score
  updateScore();
  displayScore();
  checkEnd(my_box_color, opp_box_color);
  
  println(ball_vel.mag());
}
