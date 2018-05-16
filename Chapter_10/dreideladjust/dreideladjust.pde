// dreidel
//use of texture to put images on spinning top
//cylinder with facets for peg
//spinning for random amount and does slow down
//undocumented feature to restart spinning using any key
//undocumented feature to rotate in 2 dimensions using mouse

PImage hay, shin, gimmel, nun;
float roty = 0;   //amount to rotate around y axis
                  // set by spin, mouseDragged
float rotx = 0;   //amount to rotate around x axis. Only set by mouseDragged

int spinCount = 200 + int(random(100));   //initial setting, decremented in spin
float delta = .09;      //amount to change roty
Boolean adjust = true;
String[] msgs = {
  "Take half.",
  "Do nothing.",
  "Take all.",
  "Put in 1."
};
void setup() {
  size(800,600,P3D);
  hay = loadImage("hay.jpeg");
  shin  = loadImage("shin.jpeg");
  gimmel = loadImage("gimmel.jpeg");
  nun = loadImage("nun.jpeg");
  textureMode(NORMAL);
  frameRate(30);
 
}
void draw() {
  background(200);  //erase screen 
  spin();  //sets roty
  
  translate(width/2.0, height/2.0, -100);
  rotateX(rotx);
  rotateY(roty);
  scale(50); 
  dreidelparts(hay,gimmel,nun,shin);
}

void spin() {  //prepares variables for the rotation, to be done in draw
  spinCount--;
  
  if (spinCount>0) {
   
   
    roty=roty+delta;
    delta = .999*delta;  //prepares for slowing down next iteration
   
  }
  else {
   float turns = roty / HALF_PI;   //number of quarter turns
   int wturns = int(turns+.5); // round off to closest integer
   int ans = wturns % 4;
   String msg = msgs[ans];
   if (adjust) {
     adjust = false;
     roty =wturns*HALF_PI;
     println(msg);
     
   }
  }
}

void keyPressed() {  //re-start spinning
  roty=0;
  spinCount=200+int(random(100));  //200 frames plus random value of frames
  delta = .09;
  adjust = true;
}

void dreidelparts(PImage tex1, PImage tex2, PImage tex3, PImage tex4) {
  //cube part from https://processing.org/examples/texturecube.html
  fill(255,215,0);
  pushMatrix();
  translate(0,-1,0);
  drawCylinder(24,.2,2.0);
  popMatrix();
  
  noStroke();
  beginShape(QUADS);
  texture(tex1);

  // modified code to use 4 images, not top and bot
  
  // +Z "front" face
  vertex(-1, -1,  1, 0, 0);
  vertex( 1, -1,  1, 1, 0);
  vertex( 1,  1,  1, 1, 1);
  vertex(-1,  1,  1, 0, 1);
 endShape();
 
 beginShape();
  texture(tex2);
    // -Z "back" face
  vertex( 1, -1, -1, 0, 0);
  vertex(-1, -1, -1, 1, 0);
  vertex(-1,  1, -1, 1, 1);
  vertex( 1,  1, -1, 0, 1);

 endShape();

  
  beginShape(QUADS);
  texture(tex3);
 

    // -X "left" face
  vertex(-1, -1, -1, 0, 0);
  vertex(-1, -1,  1, 1, 0);
  vertex(-1,  1,  1, 1, 1);
  vertex(-1,  1, -1, 0, 1);
 endShape();
 
 beginShape();
   texture(tex4);

  // +X "right" face
  vertex( 1, -1,  1, 0, 0);
  vertex( 1, -1, -1, 1, 0);
  vertex( 1,  1, -1, 1, 1);
  vertex( 1,  1,  1, 0, 1);

  endShape();
  //top
  fill(100,0,100);
  
  beginShape();
    vertex(-1,-1,1);
    vertex(-1,-1,-1);
    vertex(1,-1,-1);
    vertex(1,-1,1);
    vertex(-1,-1,1); 
  endShape();
  fill(100,100,0);
  //bottom triangle from each of the 4 sides to center point
  beginShape();
    vertex(-1,1,1);
    vertex(-1,1,-1);
    vertex(0,2,0);
    vertex(-1,1,1);
  endShape(CLOSE);
  fill(100,0,0);
  beginShape();
    vertex(1,1,1);
    vertex(1,1,-1);
    vertex(0,2,0);
    vertex(1,1,1);
  endShape(CLOSE);
  
  fill(0,100,0);
  beginShape();
    vertex(-1,1,-1);
    vertex(1,1,-1);
    vertex(0,2,0);
    vertex(-1,1,-1);
  endShape(CLOSE);
  
  fill(0,0,100);
  beginShape();
    vertex(-1,1,1);
    vertex(1,1,1);
    vertex(0,2,0);
    vertex(-1,1,1);
  endShape(CLOSE);
}


//used for the peg at top. Invoked by dreidelparts
//orientaion changed from online example to switch to y from z.
//from Processing http://vormplus.be/blog/article/drawing-a-cylinder-with-processing
// positioned to be at top of cube.
void drawCylinder(int sides, float r, float h)
{
    float angle = 360 / sides;
    float halfHeight = h / 2;
    // draw top shape
    
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float z = sin( radians( i * angle ) ) * r;
        vertex( x,  -halfHeight,z );    
    }
    endShape(CLOSE);
   
    // draw bottom shape
    beginShape();
    for (int i = 0; i < sides; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float z = sin( radians( i * angle ) ) * r;
        vertex( x, halfHeight,z );    
    }
    endShape(CLOSE);
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
       float x = cos( radians( i * angle ) ) * r;
       float z = sin( radians( i * angle ) ) * r;
       vertex( x, halfHeight, z);
       vertex( x, -halfHeight, z);    
     }
    endShape(CLOSE); 
    
} 



//enhancement could be to let player know about the mouse and key features

void mouseDragged() {
  float rate = 0.01;
  rotx += (pmouseY-mouseY) * rate;
  roty += (mouseX-pmouseX) * rate;
}