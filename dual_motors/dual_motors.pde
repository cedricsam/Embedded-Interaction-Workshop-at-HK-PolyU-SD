#include <Servo.h>
Servo myservo1, myservo2;
boolean button1, button2;
boolean changeOfState;
int lastState, state;
int MAXANGLE = 163;
int MIDANGLE = 82;
int MINANGLE = 0;
int angle1 = MIDANGLE;
int angle2 = MIDANGLE;
int WAIT = 100;
int PUSHWAIT = 1000;
long releaseTime1, releaseTime2;
boolean pushing1, pushing2;
boolean lock1, lock2;
void setup () {
  button1 = HIGH;
  button2 = HIGH;
  Serial.begin(9600);
  pinMode(3, OUTPUT);
  pinMode(11, OUTPUT);
  pinMode(4, INPUT);
  pinMode(12, INPUT);
  myservo1.attach(11);
  myservo2.attach(3);
  myservo1.write(angle1);
  myservo2.write(angle2);
  pushing1 = false;
  pushing2 = false;
  releaseTime1 = 0;
  releaseTime2 = 0;
  lock1 = false;
  lock2 = false;
}
void loop () {
  // read the buttons
  button1 = digitalRead(12);
  button2 = digitalRead(4);

  // SET 1
  if (!lock2) {
    if (button1==LOW || pushing1) { // button 1 is pressed
      if (!pushing1) {
        Serial.println(1);
        lock1 = true;
        pushing1 = true;
        releaseTime1 = millis() + PUSHWAIT;
      } 
      else {
        if (releaseTime1 > 0) {
          if (millis() < releaseTime1) { // not releasing yet
            if (angle1 != MAXANGLE) { // not set to the max angle
              lock1 = true; // reiterate the lock
              angle1 = MAXANGLE;
            }
          } 
          else { // time to release
            if (angle1 != MIDANGLE) angle1 = MIDANGLE;
            lock1 = false;
            releaseTime1 = 0;
          }
        }
      }
      myservo2.write(angle1);
    }
  }
  if (button1==HIGH && angle1 == MIDANGLE) pushing1 = false;
  
  // SET 2
  if (!lock1) {
    if (button2==LOW  || pushing2) { // button 2 is pressed
      if (!pushing2) {
        Serial.println(2);
        lock2 = true;
        pushing2 = true;
        releaseTime2 = millis() + PUSHWAIT;
      } 
      else {
        if (releaseTime2 > 0) {
          if (millis() < releaseTime2) {
            if (angle2 != MAXANGLE) {
              lock2 = true;
              angle2 = MAXANGLE;
            }
          } 
          else {
            if (angle2 != MIDANGLE) angle2 = MIDANGLE;
            lock2 = false;
            releaseTime2 = 0;
            //pushing2 = false;
          }
        }
      }
      myservo1.write(angle2);
    }
  }
  if (button2==HIGH && angle2 == MIDANGLE) pushing2 = false;
  
  if (!(millis() % 3000)) {
    Serial.println(millis());
    if (lock1) {
    Serial.println("LOCK#1");
    }
    if (lock2) {
    Serial.println("LOCK#2");
    }
    if (releaseTime1) {
    Serial.println(releaseTime1);
    }
    if (releaseTime2) {
    Serial.println(releaseTime2);
    }
    if (button1==LOW) {
    Serial.println("1LOW");
    }
    if (button1==HIGH) {
    Serial.println("1HIGH");
    }
    if (button2==LOW) {
    Serial.println("2LOW");
    }
    if (button2==HIGH) {
    Serial.println("2HIGH");
    }
  }
}
