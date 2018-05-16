float bx,by,dx,dy;
int balldiam = 100;
int nsides = 5;

void setup() {
  size(800,600);  
  bx = width/2;
  by = height/2;
  dx = 1;
  dy = 2; 
  stroke(255);
}

void draw(){
  background(0);  
  polygon(bx,by,balldiam,nsides);
  bx = bx+dx;
  if ((bx>=width)||(bx<=0)) 
      {dx = -dx;}
  by = by + dy;
  if ((by>=height)||(by<=0)) 
      {dy = -dy;}
}

void polygon(float x, float y, float w, int n)
{
  float angle = TWO_PI / n;
  float rad = w/2;
  for (int i=0;i<n;i++)
    {
      float pangle1 = angle * i;
      float pangle2 = angle * (i+1);
      float xp1 = x + rad * cos(pangle1);
      float yp1 = y + rad * sin(pangle1);
      float xp2 = x + rad* cos(pangle2);
      float yp2 = y + rad * sin(pangle2);
      line(xp1,yp1,xp2,yp2);    
    }  
}

void mousePressed() {
  nsides = 3+int(random(12));
}