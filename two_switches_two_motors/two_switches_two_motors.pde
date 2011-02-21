#include <Servo.h>
Servo myservo1, myservo2;
int red = 0;
int green = 0;
int blue = 0;
int color1, color2, color3, color4;
int sensorValue;
int MAXANGLE = 163;
int MIDANGLE = 82;
int MINANGLE = 0;
int angle1 = MIDANGLE;
int angle2 = MIDANGLE;
int WAIT = 100;
int PUSHWAIT = 1000;
int releaseTime;
boolean up;
boolean button1, button2, button3, button4;
boolean pushing;
void setup() {
  pinMode(1, INPUT);
  pinMode(2, INPUT);
  pinMode(4, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(8, OUTPUT);
  pinMode(9, OUTPUT);
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
  pushing = false;
  releaseTime = 0;
}
void loop() {
  //sensorValue = analogRead(0);
  button1 = digitalRead(12);
  button2 = digitalRead(13);
  button3 = digitalRead(1);
  button4 = digitalRead(2);
  /*color1 = map(sensorValue, 0, 400, 0, 255);
  color2 = map(sensorValue, 0, 400, 255, 0);
  color3 = map(sensorValue, 0, 400, 0, 255);
  color4 = map(sensorValue, 0, 400, 255, 0);*/
  color1 = 255;
  color2 = 255;
  if (button1==HIGH && button2==LOW) { // button 2 is pressed
    red = 0;
    green = color1;
    blue = 0;
    /*if (!(millis() % WAIT)) angle += 1;
     angle = min(179, angle);*/
    if (!pushing) {
      pushing = true;
      releaseTime = millis() + PUSHWAIT;
    } 
    else {
      if (releaseTime > 0) {
        if (millis() < releaseTime) {
          if (angle1 != MAXANGLE) {
            angle1 = MAXANGLE;
          }
        } 
        else {
          if (angle1 != MIDANGLE) angle1 = MIDANGLE;
          releaseTime = 0;
        }
      }
    }
    myservo1.write(angle1);
  } 
  else if (button1==LOW && button2==LOW || button1==HIGH && button2==HIGH) { // Both buttons are pushed or released
    if (pushing) pushing = false;
    releaseTime = 0;
    red = 0;
    green = 0;
    blue = color1;
    if (angle1 != MIDANGLE) angle1 = MIDANGLE;
    myservo1.write(angle1);
  } 
  else if (button1==LOW && button2==HIGH) { // button 1 is pressed
    red = color1;
    green = 0;
    blue = 0;
    /*if (!(millis() % WAIT)) angle -= 1;
     angle = max(0, angle);*/
    if (!pushing) {
      pushing = true;
      releaseTime = millis() + PUSHWAIT;
    } 
    else {
      if (releaseTime > 0) {
        if (millis() < releaseTime) {
          if (angle1 != MINANGLE) {
            angle1 = MINANGLE;
          }
        } 
        else {
          if (angle1 != MIDANGLE) angle1 = MIDANGLE;
          releaseTime = 0;
        }
      }
    }
    myservo1.write(angle1);
  }
  digitalWrite(8, green);
  digitalWrite(9, red);
  digitalWrite(5, green);
  digitalWrite(4, red);
  //analogWrite(9, 0);
  //analogWrite(10, 0);
  if (!(millis() % 2500)) {
    Serial.println(millis());
    Serial.println(pushing);
    /*Serial.println(button1);
     Serial.println(button2);
     Serial.println("---");*/
  }
}



