#include <Servo.h>
Servo myservo1, myservo2;
int red1 = 0;
int green1 = 0;
int blue1 = 0;
int red2 = 0;
int green2 = 0;
int blue2 = 0;
int sensorValue;
int MAXANGLE = 163;
int MIDANGLE = 82;
int MINANGLE = 0;
int angle1 = MIDANGLE;
int angle2 = MIDANGLE;
int WAIT = 100;
int PUSHWAIT = 1000;
int releaseTime1, releaseTime2;
boolean up;
boolean button1, button2, button3, button4;
boolean pushing1, pushing2;
boolean lock1, lock2;
void setup() {
  pinMode(2, INPUT);
  pinMode(4, INPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(9, OUTPUT);
  pinMode(10, OUTPUT);
  pinMode(12, INPUT);
  pinMode(13, INPUT);
  Serial.begin(9600);
  button1 = false;
  button2 = false;
  button3 = false;
  button4 = false;
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
void loop() {
  //sensorValue = analogRead(0);
  button1 = digitalRead(13);
  button2 = digitalRead(12);
  button3 = digitalRead(2);
  button4 = digitalRead(4);
  
  // SET 1
  if (!lock2) {
    if (button1==HIGH && button2==LOW) { // button 2 is pressed
      red1 = 0;
      green1 = 255;
      blue1 = 0;
      red2 = 255;
      green2 = 0;
      blue2 = 0;
      if (!pushing1) {
        lock1 = true;
        pushing1 = true;
        releaseTime1 = millis() + PUSHWAIT;
      } 
      else {
        if (releaseTime1 > 0) {
          if (millis() < releaseTime1) {
            if (angle1 != MAXANGLE) {
              lock1 = true;
              angle1 = MAXANGLE;
            }
          } 
          else {
            if (angle1 != MIDANGLE) angle1 = MIDANGLE;
            lock1 = false;
            releaseTime1 = 0;
          }
        }
      }
      myservo2.write(angle1);
    } 
    else if (button1==LOW && button2==LOW || button1==HIGH && button2==HIGH) { // Both buttons are pushed or released
      if (pushing1) pushing1 = false;
      if (lock1) lock1 = false;
      releaseTime1 = 0;
      red1 = 0;
      green1 = 0;
      blue1 = 255;
      red2 = 0;
      green2 = 0;
      blue2 = 255;
      if (angle1 != MIDANGLE) angle1 = MIDANGLE;
      myservo2.write(angle1);
    } 
    else if (button1==LOW && button2==HIGH) { // button 1 is pressed
      red1 = 255;
      green1 = 0;
      blue1 = 0;
      red2 = 0;
      green2 = 255;
      blue2 = 0;
      if (!pushing1) {
        lock1 = true;
        pushing1 = true;
        releaseTime1 = millis() + PUSHWAIT;
      } 
      else {
        if (releaseTime1 > 0) {
          if (millis() < releaseTime1) {
            if (angle1 != MINANGLE) {
              lock1 = true;
              angle1 = MINANGLE;
            }
          } 
          else {
            lock1 = false;
            if (angle1 != MIDANGLE) angle1 = MIDANGLE;
            releaseTime1 = 0;
          }
        }
      }
      myservo2.write(angle1);
    }
  }
  
  
  // SET 2
  if (!lock1) {
    if (button3==HIGH && button4==LOW) { // button 2 is pressed
      red1 = 255;
      green1 = 0;
      blue1 = 0;
      red2 = 0;
      green2 = 255;
      blue2 = 0;
      if (!pushing2) {
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
          }
        }
      }
      myservo1.write(angle2);
    }
    else if (button3==LOW && button4==LOW || button3==HIGH && button4==HIGH) { // Both buttons are pushed or released
      if (pushing2) pushing2 = false;
      if (lock2) lock2 = false;
      releaseTime2 = 0;
      red1 = 0;
      green1 = 0;
      blue1 = 255;
      red2 = 0;
      green2 = 0;
      blue2 = 255;
      if (angle2 != MIDANGLE) angle2 = MIDANGLE;
      myservo1.write(angle2);
    } 
    else if (button3==LOW && button4==HIGH) { // button 1 is pressed
      red1 = 0;
      green1 = 255;
      blue1 = 0;
      red2 = 255;
      green2 = 0;
      blue2 = 0;
      if (!pushing2) {
        lock2 = true;
        pushing2 = true;
        releaseTime2 = millis() + PUSHWAIT;
      } 
      else {
        if (releaseTime2 > 0) {
          if (millis() < releaseTime2) {
            if (angle2 != MINANGLE) {
              lock2 = true;
              angle2 = MINANGLE;
            }
          } 
          else {
            if (angle2 != MIDANGLE) angle2 = MIDANGLE;
            lock2 = false;
            releaseTime2 = 0;
          }
        }
      }
      myservo1.write(angle2);
    }
  }
  digitalWrite(9, red1);
  digitalWrite(10, green1);

  digitalWrite(5, red2);
  digitalWrite(6, green2);
  if (!(millis() % 2500)) {
    Serial.println(millis());
    Serial.println(pushing1);
    Serial.println(pushing2);
  }
}



