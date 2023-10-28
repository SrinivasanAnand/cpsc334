
// Constants
int Y_AXIS = 1;
int X_AXIS = 2;

int count = 0;
int step = 25;
int wait_time = 0;
int fade_interval = 30;
color b1, b2, b3, b4;
color[] gradient_array = new color[4];
color inter1, inter2, new_inter1, new_inter2;
float fade_amount = 0;

int xspacing = 3;   // How far apart should each horizontal location be spaced
int w;              // Width of entire wave
int maxwaves = 7;   // total # of waves to add together

float theta = 0.0;
float[] amplitude = new float[maxwaves];   // Height of wave
float[] dx = new float[maxwaves];          // Value for incrementing X, to be calculated as a function of period and xspacing
float[] yvalues;                           // Using an array to store height values for the wave (not entirely necessary)
float period;

//float[] amplitude_new = new float[maxwaves];   
//float[] dx_new = new float[maxwaves];          
//float[] yvalues_new;     
//float period_new;

int amp_max;
int amp_min;

float growth_rate = random(0, 2);

int test_wait = 200;

int log_index = 0;
int msg_start = 27;
int current_log_file_len = 0;

int touch_val;
boolean touch_val_scaled = false;
int touch_threshold = 40;
boolean touch_flag = false;
int replay_count = 0;
int wait_count = 1;
int repeat_count = 8;

int light_val;
float light_val_scaled;
float calibration;
boolean calibrated = false;


void setup() {
  //size(640, 360);
  fullScreen();
  noStroke();
  // Define colors
  b1 = color(165, 42, 42);
  b2 = color(204, 85, 0);
  b3 = color(255, 234, 0);
  b4 = color(0); //110, 38, 14
  
  gradient_array[0] = b1;
  gradient_array[1] = b2;
  gradient_array[2] = b3;
  gradient_array[3] = b4;
  
  amp_max = 100;
  amp_min = 15;
  
  //colorMode(RGB, 255, 255, 255, 100);
  w = width + 16;

  for (int i = 0; i < maxwaves; i++) {
        amplitude[i] = random(15, amp_max);
        period = random(width/6,width/4);
        dx[i] = (TWO_PI / period) * xspacing;
  }

  yvalues = new float[w/xspacing];
  
  
  frameRate(15);
}

void draw() {
  background(0);
  
  
  get_input();
  scale_input();
  
  //pickAmplitude();
  pickGradient();
  
  calcWave();
  renderWave();
  
  replay();
  if (touch_flag == false) {
    grow(light_val_scaled);
  }
  
  bottomGradient();
}


//void pickAmplitude() {
//  if (wait_time == 0) {
//    for (int i = 0; i < maxwaves; i++) {
//        amplitude_new[i] = random(0,80);
//        //period_new = random(100,300);
//        //dx_new[i] = (TWO_PI / period) * xspacing;
//    }
//  }
//  fadeAmplitude();
//}

//void fadeAmplitude(){
//  if (fade_amount < 1) {
//    float[] amplitude_inter = new float[maxwaves];
//    //float[] dx_inter = new float[maxwaves];
//    for (int i = 0; i < maxwaves; i++) {    
//        amplitude_inter[i] = (amplitude[i] - amplitude_new[i])*fade_amount + amplitude[i];
//        //float period_inter = (period - period_new)*fade_amount + period;    
//        //dx_inter[i] = (TWO_PI / period_inter) * xspacing;
//    }
//    setAmplitude(amplitude_inter);
//  }
//  else {
//    amplitude = amplitude_new;
//    period = period_new;
//    dx = dx_new;
//    setAmplitude(amplitude);
//  }
//}

//void setAmplitude(float amp[]){
//  for (int i = 0; i < maxwaves; i++) {
//        amplitude[i] = amp[i];
//  }
//}
