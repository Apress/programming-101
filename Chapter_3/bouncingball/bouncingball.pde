//bouncing ball
float bx,by,dx,dy;
int balldiam = 20;

void setup() {
  size(800,600);
  bx = width/2;
  by = height/2;
  dx = 1;
  dy = 2;  
}

void draw(){
  background(0);  //erase window
  ellipse(bx,by,balldiam,balldiam);
  bx = bx+dx;
  if ((bx>=width)||(bx<=0)) 
      {dx = -dx;}
  by = by + dy;
  if ((by>=height)||(by<=0)) 
      {dy = -dy;}
}