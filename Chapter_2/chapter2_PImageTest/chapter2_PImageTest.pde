// coin flip
PImage myGD;

void setup() {
   size(1000,1000);
   myGD = loadImage("smirk.JPG");
   
}
void draw() {
  image(myGD,10,10);
  image(myGD,20,20,300,300);
}