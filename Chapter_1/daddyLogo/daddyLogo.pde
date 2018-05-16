// This produces a peanut-like shape that was a self-portrait by my father
//he sometimes used it as a signature.
//daddy using variables and function
// this version draws two different faces

int ctrx = 100;
int ctry = 160;
int faceWidth = 80;
int faceHeight = 100;
int skinnyFaceWidth = 60;
int skinnyFaceHeight = 130;
int eyeSize = 10;
color skinTone = color(255,224,189);


void setup()
{
  size(800,600);
  ellipseMode(CENTER);
}

void draw()
{
  daddy(ctrx,ctry,faceWidth, faceHeight );
  daddy(3*ctrx, 2*ctry,skinnyFaceWidth, skinnyFaceHeight );
}

void daddy(int x,int y, int w, int h)
{
  noStroke();
  fill(skinTone);
  
  int eyeXoffset = int((15.0/80.0)*w);
  int eyeYoffset = int(.35*h);
   int mouthYoffset = int(.10*h);
  int mouthWidth = int(.5*w);
  int mouthHeight = int(.3*h);
  int hairOffsetY = eyeYoffset*3;
  int hairRadius = 3*eyeSize;
  ellipse(x,y,1.2*w,h);
  ellipse(x,y-h/2,w,h);
  stroke(0);
  fill(0);
  ellipse(x-eyeXoffset,y-eyeYoffset,eyeSize,eyeSize);
  ellipse(x+eyeXoffset,y-eyeYoffset,eyeSize,eyeSize);
  noFill();
  arc(x,y-hairOffsetY,hairRadius,hairRadius,-PI/2,PI/2);
  arc(x,y-hairOffsetY-hairRadius,hairRadius,hairRadius,PI/2,PI*3/2);
  stroke(240,0,0);
  arc(x,y+mouthYoffset,mouthWidth,mouthHeight,QUARTER_PI,3*QUARTER_PI);
}