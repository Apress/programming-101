PImage bg;
float x,y,z;
float xstart = 150;
float xend = 320;
float ylevel = 400;
float zstart = -50;
float zend = 450;
boolean forward = true;
void setup()
{
  size(500,740,P3D);
  bg = loadImage("alhambra.jpg");
  background(bg);
  x = xstart;
  y = ylevel;
  z = zend;
  noStroke();
}
void draw() {
  background(bg);
 lights();
  fill(240,0,240);
   if (forward) {
  forwardtravel();
}
 else {
   backwardtravel();
 }
}

void forwardtravel() {
  if ((z>zstart)&&(x==xstart)) {
     z--;
   translate(x,y,z);}
   else { if (x<xend) {
       x++;
       translate(x,y,z);
     }
     else { z++;
      translate(x,y,z); 
      if (z>zend) {forward = false;};
     }
   }
   fill(240,0,240);
   sphere(8); 
   }
void backwardtravel() {
   if ((z>zstart)&&(x>=xend)) {
     z--;
   translate(x,y,z);}
   else { if (x>xstart) {
       x--;
       translate(x,y,z);
     }
     else { z++;
      translate(x,y,z); 
      if (z>zend) {forward = true;};
     }
   }
   
   sphere(8); 
}