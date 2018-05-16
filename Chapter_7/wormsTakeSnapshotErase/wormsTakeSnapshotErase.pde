//make a path and then follow it
Location[] path = {};
Boolean pathmade = false;  //first phase
Boolean started = false;
int pathI = 0;  //index into path
String instructions = "Press mouse button down, drag, and release to make a path.\n" +
   "Press c for clear and s for save snapshot.";
void setup() {
  background(255);
  size(600,600);
  fill(0);
  text(instructions,10,20);
  fill(255);
  
}
void draw()
{
  fill(0);
  text(instructions,10,20);
  fill(255);
  if (pathmade)
  {
    Location p = path[pathI++];
    ellipse(p.getxp(),p.getyp(),20,20);
    if (pathI>=path.length) {pathI = 0;}
  }
}
void keyPressed(){
  switch(key) {
    case 'c':
      path = new Location[0];
      pathI = 0;
      pathmade = false;
      started = false;
      background(255);
      fill(0);
      text(instructions, 10,20);
      fill(255);
      break;
    case 's':
       saveFrame("snaps/worms####.png");
       break;
  }
  
}
void mousePressed(){
  started = true;  //will add to the path
  pathmade = false;
  path = (Location[]) append(path,new Location(mouseX,mouseY));
}  
 void mouseDragged(){
  if (started){
   path = (Location[]) append(path,new Location(mouseX,mouseY)); 
   }
}
void mouseReleased()
{
  started = false;
  pathmade = true;
}

class Location { 
 float xp;
 float yp;
 Location (float x, float y) {
    xp = x;
    yp = y;
 } 
 float getxp() {
   return xp;
 }
 float getyp() {
   return yp;
 }
}