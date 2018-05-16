//coin toss type of example showing photos 
//also reverts after set time period

int lastChange;
int limit = 3000;
String msg = "Click anywhere for the bull or the fearless girl(s).";

PImage girls;
PImage bull;


void setup() {
  lastChange = millis();
  size(1200,1200);
  girls = loadImage("annikaWithFearlessGirl.jpg");
  background(255);
  bull = loadImage("bull.jpg");
  fill(0);
  textSize(30);
  text(msg,100,100);
  
}

void draw() {
  if ((millis()-lastChange)>limit) {
    background(255);
    text(msg, 100, 100);
  }
  
}

void mouseClicked() {
   lastChange = millis();
   background(255);
   if (random(1)>=.5) {
     image (girls,10,10);
   }
   else {
     image (bull,10,10);
   }
  
}
  