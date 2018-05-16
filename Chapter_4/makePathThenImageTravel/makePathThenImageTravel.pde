//make a path and then follow it
Location[] path = {};
Boolean pathmade = false;  //first phase
//Boolean started = false;
int pathI = 0;  //index into path
String instructions = "Press mouse button down, drag, and release to make a path";
 //dimensions of image is 512 x 768
 /*
float imageW = 512/3;
float imageH = 768/3;
float half_imageW = imageW/2;
float half_imageH = imageH/2;
*/
float imageW;
float imageH;
float half_imageW;
float half_imageH;
PImage biker;


void setup() {
  size(900, 600);
  background(255);
  
  biker = loadImage("bikerchickWGrant.jpg");
  imageW = biker.width/3;
  imageH = biker.height/3;
  half_imageW = imageW/2;
  half_imageH = imageH/2;
  strokeWeight(3);

  fill(0);
  textSize(24);
  text(instructions,10,20);
  frameRate(30);
}
void draw()
{

  if (pathmade)
  {
    background(255);
 
    text(instructions,10,20);
    Location p = path[pathI];
    pathI++;
    image(biker,p.xp-half_imageW,p.yp-half_imageH,imageW,imageH);
    if (pathI>=path.length) {pathI = 0;}
  }
  //does nothing if path making is in process
  
}
void mousePressed(){

  path = new Location[0];  //resets to be empty
  pathI = 0;
  pathmade = false;  //path making underway. No drawing of image
  path = (Location[]) append(path,new Location(mouseX,mouseY));
  
}  
 void mouseDragged(){

   path = (Location[]) append(path,new Location(mouseX,mouseY)); 
   //draw line segment from last location
   line(pmouseX,pmouseY,mouseX,mouseY);

}
void mouseReleased()
{
 
  pathmade = true;  // will now draw image
}

class Location { 
 float xp;
 float yp;
 Location (float x, float y) {
    xp = x;
    yp = y;
 }

}