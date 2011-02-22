int red, green, blue;
boolean button1, button2;
boolean changeOfState;
int lastState, state;
void setup() {
  pinMode(3, OUTPUT);
  pinMode(5, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(12, INPUT);
  pinMode(13, INPUT);
  button1 = false;
  button2 = false;
  lastState = 0;
  state = 0;
  red = 0;
  green = 0;
  blue = 0;
  Serial.begin(9600);
}
void loop() {
  button1 = digitalRead(12);
  button2 = digitalRead(13);
  if (button1 && button2) { // both pushed
    state = 3;
    red = 255;
    green = 255;
    blue = 0;
  } else if (button1 && !button2) { // button 1 pushed
    state = 1;
    red = 0;
    green = 255;
    blue = 0;
  } else if (!button1 && button2) { // button 2 pushed
    state = 2;
    red = 255;
    green = 0;
    blue = 0;
  } else if (!button1 && !button2) { // both off
    state = 0;
    red = 0;
    green = 0;
    blue = 255;
  }
  digitalWrite(3, red);
  digitalWrite(5, green);
  digitalWrite(6, blue);
  if (lastState != state) {
    Serial.println(state);
  }
  lastState = state;
}
