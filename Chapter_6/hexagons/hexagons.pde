//makes hexagon origami combination at mouse location
//makes filled in polygon
//polygons are NOT regular hexagons
//4 layers

float fudge = 3;
void setup()
{
  size(1000,900);
  fill(200,0,100);
  textSize(18);
  text("Click on screen, press any key to clear the screen",20,20);
  // hexShape(400,400,300);
  //hexLayer(500,400,300);
 // hexCombo(500,500,300);  //draws combo over and over, random rotation
}
void draw()
{
}

void mouseReleased()
{
  //draw a combo at mouse location
  hexCombo(mouseX,mouseY,200);
}
void hexCombo(float cx, float cy, float startSize) {
    float curSize = startSize;
    translate(cx,cy);
    rotate(random(HALF_PI));
    hexLayer(0,0,curSize);
    pushMatrix();
    //translate(0,0);  //was translate(cx,cy);
    rotate(PI/4);
    curSize = curSize/sqrt(2);
    hexLayer(0,0,curSize);
    rotate(PI/4);
    curSize = curSize/sqrt(2);
    hexLayer(0,0,curSize);
    rotate(PI/4);
    curSize = curSize/sqrt(2);
    hexLayer(0,0,curSize);
    popMatrix();
}
void hexLayer(float cx, float cy,float layerSize) {
   float pctrx, pctry;
   float hexSize = layerSize;
   fill(200,0,100);  //not needed, but keep it just in case I want to change color
    pctrx =.5*hexSize+fudge;
      pctry = 0;
   for (int i=0;i<4;i++){
      pushMatrix();
      translate(cx,cy);
      rotate(HALF_PI*i);
      hexShape(pctrx,pctry,.5*hexSize);  
      popMatrix();
   }
   
   
}
void hexShape(float cx, float cy, float hexSize)
{
  //cx and cy are center of circle for which this is 
  //an inscribed NOT regular hexagon. The hexSize is like radius.
  
  beginShape();
   vertex(cx+hexSize,cy);
   vertex(cx+hexSize*.5,cy-hexSize*.5);
   vertex(cx-hexSize*.5,cy-hexSize*.5);
   vertex(cx-hexSize,cy);
   vertex(cx-hexSize*.5,cy+hexSize*.5);
   vertex(cx+hexSize*.5,cy+hexSize*.5);
  endShape(CLOSE);
  
}
void keyPressed()
{background(200,200,200);
text("Click on screen, press any key to clear the screen",20,20);
}