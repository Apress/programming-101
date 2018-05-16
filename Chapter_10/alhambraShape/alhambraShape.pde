PImage bg;
float x,y,z;
float xstart = 150;
float xend = 330;
float ylevel = 400;
float zstart = -50;
float zend = 450;
boolean forward = true;
float a=0;
PShape ball;
Boolean moving = true;
String msg = "Press any key to stop or restart.";

void setup() {
  size(500,740,P3D);
  noStroke();
  sphereDetail(15);
  bg = loadImage("alhambra.jpg");
  PImage design = loadImage("flag.png");
  ball = createShape(SPHERE,10);
  ball.setTexture(design);
  background(bg);
  x = xstart;
  y = ylevel;
  z = zend;
  textSize(20);
}

void draw() {
  if (moving) {
  background(bg);
  fill(0);
  rect(0,700,500,40);
  fill(250,0,0);
  text(msg,100,720);
 lights();
  
   if (forward) {
  forwardtravel();
}
 else {
   backwardtravel();
 }
 }
}

void forwardtravel() {
  if ((z>zstart)&&(x==xstart)) {
     z--;
    rotateAndDraw(1);
 
    }
   else { if (x<xend) {
       x++;
     rotateAndDraw(2);
     }
     else { z++;
   rotateAndDraw(3);
      if (z>zend) {forward = false;};
     }
   }
 }
 
void backwardtravel() {
   if ((z>zstart)&&(x>=xend)) {
     z--;
     rotateAndDraw(4);
     }
   else { if (x>xstart) {
       x--;
       rotateAndDraw(5);
     }
     else { z++;
      rotateAndDraw(6);
      if (z>zend) {forward = true;};
     }
   }
}

void rotateAndDraw(int p) {
    a=a+PI/10;
    translate(x,y,z);
  switch(p) {
    case 1:
    rotateX(a);
    break;
    case 2:
     rotateZ(a);
     break;
    case 3:
      rotateX(-a);
      break;
    case 4:
      rotateX(a);
      break;
    case 5:
      rotateZ(-a);
     break;
    case 6:
      rotateX(-a);  
      break;
  }
  shape(ball); 
}

void keyPressed() {
  moving = !moving;
}