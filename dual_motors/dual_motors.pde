#include <Servo.h>
boolean DEBUG = false;
int DELAYNOMORE = 50;
Servo myservo1, myservo2;
boolean button1, button2;
boolean changeOfState;
boolean up1, up2;
int lastState, state;
int MAXANGLE = 163;
int MIDANGLE = 82;
int MINANGLE = 0;
int angle1 = MIDANGLE;
int angle2 = MIDANGLE;
int WAIT = 100;
int PUSHWAIT = 500;
float d = 0.05;
float x = 0;
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
  up1 = true;
  up2 = true;
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
        up1 = true;
        x = (float)(MAXANGLE - angle1) * d;
        //Serial.println(x);
      } 
      else {
        if (releaseTime1 <= 0) {
          if (angle1 <= MAXANGLE && angle1 >= MIDANGLE) {
            if (up1) angle1 = (int)((float)angle1 + x);
            else {
              angle1 = (int)((float)angle1 - x);
            }
            delay(DELAYNOMORE);
          } else if (angle1 > MAXANGLE) {
            if (up1) up1 = false;
            angle1 = MAXANGLE; // make sure we don't sit between increments
            releaseTime1 = millis() + PUSHWAIT; // set the release time when attained the max angle
          } else if (angle1 < MIDANGLE) {
            lock1 = false;
            angle1 = MIDANGLE;
          }
        } else {
          if (millis() < releaseTime1) { // not releasing yet
            lock1 = true; // reiterate the lock
            angle1 = MAXANGLE;
          } 
          else { // time to release
            up1 = false;
            releaseTime1 = 0;
          }
        }
      }
      myservo2.write(angle1);
    }
  }
  if (button1==HIGH && angle1 == MIDANGLE) {
    pushing1 = false;
    lock1 = false;
  }

  // SET 2
  if (!lock1) {
    if (button2==LOW || pushing2) { // button 2 is pressed
      if (!pushing2) {
        Serial.println(2);
        lock2 = true;
        pushing2 = true;
        up2 = true;
        x = (float)(MAXANGLE - angle2) * d;
      } 
      else {
        if (releaseTime2 <= 0) {
          if (angle2 <= MAXANGLE && angle2 >= MIDANGLE) {
            if (up2) angle2 = (int)((float)angle2 + x);
            else angle2 = (int)((float)angle2 - x);
            delay(DELAYNOMORE);
          } else if (angle2 > MAXANGLE) {
            if (up2) up2 = false;
            angle2 = MAXANGLE; // make sure we don't sit between increments
            releaseTime2 = millis() + PUSHWAIT; // set the release time when attained the max angle
          } else if (angle2 < MIDANGLE) {
            lock2 = false;
            angle2 = MIDANGLE;
          }
        } else {
          if (millis() < releaseTime2) { // not releasing yet
            lock2 = true; // reiterate the lock
            angle2 = MAXANGLE;
          } 
          else { // time to release
            up2 = false;
            releaseTime2 = 0;
          }
        }
      }
      myservo1.write(angle2);
    }
  }
  if (button2==HIGH && angle2 == MIDANGLE) {
    pushing2 = false;
    lock2 = false;
  }
  
  if (!(millis() % 3000)&&DEBUG) {
    Serial.print(millis());
    Serial.print(" / ");
    Serial.print(releaseTime1);
    Serial.print(" / ");
    Serial.println(releaseTime2);
    if (up1) {
    Serial.println("UP#1");
    } else {
      Serial.println("DOWN#1");
    }
    if (up2) {
    Serial.println("PUSH#2");
    } else {
      Serial.println("DOWN#2");
    }
    if (pushing1) {
    Serial.println("PUSH#1");
    }
    if (pushing2) {
    Serial.println("PUSH#2");
    }    
    if (lock1) {
    Serial.println("LOCK#1");
    }
    if (lock2) {
    Serial.println("LOCK#2");
    }
    Serial.println(angle1);
    Serial.println(angle2);
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
