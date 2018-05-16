//from Processing documentation
/* @pjs preload="AnnikaFrog.JPG,AnnikaFlowers.JPG,AnnikaMakeup.jpg";
*/
PImage frog, flowers, makeup;
float rotx = PI/4;
float roty = PI/4;
int last;
int interval = 6000; //time alloted before cube rotates by itself

void setup() {
  size(1000, 1000, P3D);
  frog = loadImage("AnnikaFrog.JPG");
  flowers = loadImage("AnnikaFlowers.JPG");
  makeup = loadImage("AnnikaMakeup.jpg");
  textureMode(NORMAL);
  last = millis();
}

void draw() {
  background(0);
  textSize(20);
  text("Drag using mouse anywhere on screen to rotate cube. If no action, cube will rotate by itself.",17,14);
  noStroke();
  translate(width/2.0, height/2.0, -100);
  if ((millis()-last) > interval) {
    setRotation();
  }
  rotateX(rotx);
  rotateY(roty);
  scale(200);
  TexturedCube(frog,flowers,makeup);
}

void setRotation() {
   rotx += PI/400;
   roty += PI/400;
}

void TexturedCube(PImage tex1, PImage tex2, PImage tex3) {
  beginShape(QUADS);
  texture(tex1);

  // modified code to use 3 images
  
  // +Z "front" face
  vertex(-1, -1,  1, 0, 0);
  vertex( 1, -1,  1, 1, 0);
  vertex( 1,  1,  1, 1, 1);
  vertex(-1,  1,  1, 0, 1);

    // -Z "back" face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1,  1, -1, 1, 1);
  vertex( 1,  1, -1, 0, 1);

 endShape();
  
  beginShape(QUADS);
  texture(tex2);
 

    // -Y "top" face
  vertex(-1, -1, -1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1, -1,  1, 1, 1);
  vertex(-1, -1,  1, 0, 1);


  // +Y "bottom" face
  vertex(-1,  1,  1, 0, 0);
  vertex( 1,  1,  1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex(-1,  1, -1, 0, 1);


 endShape();
  
  beginShape(QUADS);
  texture(tex3);
 

    // -X "left" face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1,  1, 1, 0);
  vertex(-1,  1,  1, 1, 1);
  vertex(-1,  1, -1, 0, 1);


  // +X "right" face
  vertex( 1, -1,  1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex( 1,  1,  1, 0, 1);

  endShape();
}

void mouseDragged() {
  float rate = 0.01;
  last = millis();
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}