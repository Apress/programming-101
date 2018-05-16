//polygon
int choices = 3;  //minimum for a polygon
int limit = 10;
void setup()
{
  size(800,600);
  fill(255,0,0);
  textSize(18);
  text("Click on screen",20,20);
  
}
void draw()
{
  polygon(.5*width, .5*height, 100.0, 4);
}

void mouseReleased()
{
  polygon(mouseX,mouseY,100.0,choices++);
  if (choices > limit) { choices = 3;}
  
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