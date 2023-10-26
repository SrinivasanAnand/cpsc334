#include <Servo.h>


#include <Stepper.h>

const int stepsPerRevolution = 2048;  // change this to fit the number of steps per revolution

// ULN2003 Motor Driver Pins
#define IN1 19
#define IN2 18
#define IN3 5
#define IN4 17

// initialize the stepper library
Stepper myStepper(stepsPerRevolution, IN1, IN3, IN2, IN4);
Servo myservo;  // create servo object to control a servo
// twelve servo objects can be created on most boards

int pos = 0;    // variable to store the servo position
int count = 0;

void setup() {
  // set the speed at 10 rpm
  myStepper.setSpeed(10);
  // initialize the serial port
  Serial.begin(115200);

  myservo.attach(4);  // attaches the servo on pin 13 to the servo object
}

void loop() {
  Serial.println("clockwise");
  myStepper.step(stepsPerRevolution);
  

  for (count = 0; count < 10; count += 1) { // goes from 0 degrees to 180 degrees
    // in steps of 1 degree
    myservo.write(pos);              // tell servo to go to position in variable 'pos'
    pos = pos + 1;
    delay(15);                       // waits 15ms for the servo to reach the position
  }
  if (pos >= 180) {
    for (pos = 180; pos >= 0; pos -= 1) { // goes from 180 degrees to 0 degrees
      myservo.write(pos);              // tell servo to go to position in variable 'pos'
      delay(15);                       // waits 15ms for the servo to reach the position
    }
  }

  delay(100);
}
