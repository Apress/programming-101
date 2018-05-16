//testing
Boolean noFillB = true;
void setup() {
  size(800,600,P3D);
  noFill();
}

void draw() {
  background(200);
   translate(width/2,height/2,0);
  box(30);
  box(100,150,200);
}

void mouseDragged() {
  camera(mouseX, mouseY, (height/2.0) / tan(PI*30.0 / 180.0), width/2.0, height/2.0, 0, 0, 1, 0); 
}

void keyPressed() {
  if (noFillB) {
   fill(255);
   noFillB = false;
  }
  else {
   noFill();
   noFillB = true;
  }
}