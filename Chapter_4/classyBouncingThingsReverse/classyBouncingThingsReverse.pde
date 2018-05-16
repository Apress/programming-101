//classy bouncing things, reverse

Thing[] things = {};

void setup() {
   things = (Thing[]) append(things,new Ball(width/2,width/2,3,3,20));
   things = (Thing[]) append(things,new Box(width/4,width/3,2,1,40,57));
   things = (Thing[]) append(things,new Picture(width/5,width*.6,2,3,120,100,"annikalookright.jpg","annikalook.jpg"));
   things = (Thing[]) append(things,new Ball(width*.75,width/6,1,2,60));
   
   size (900,600);
  
}
void draw(){
  background(0); //erase window
  for (int i=0;i<things.length;i++) { //go through items
    things[i].show();  //might consider switching
    things[i].move();
    
  }
}

class Thing {
   float bx;
   float by;
   float dx;
   float dy;
   int wdiam;
   int hdiam;
   
   Thing (float x, float y, float vx, float vy, int w, int h)
   {  
     bx = x;
     by = y;
     dx = vx;
     dy = vy;
     wdiam = w;
     hdiam = h;
   }
   void move() {
      bx = bx + dx;
      by = by + dy;
      if ((bx>=width) || (bx<=0)) {dx = -dx;}  //might consider comparing bx+wdiam
      if ((by>=height) || (by<=0)) {dy = -dy;}  //might consider comparing by+hdiam
   } 
   void show() {
     // will be overridden by inherited objects
   }
}
class Ball extends Thing {
    // no new variables
    Ball (float x, float y, float vx, float vy, int diam) {
      super(x,y,vx,vy,diam,diam);  //wdiam and hdiam set the same
    }
    void show(){
      ellipse(bx,by,wdiam,hdiam);
    }
}
class Box extends Thing {
    // no new variables
    Box (float x, float y, float vx, float vy, int w, int h) {
      super(x,y,vx,vy,w,h);  
    }
    void show(){
      rect(bx,by,wdiam,hdiam);
    }
}
class Picture extends Thing {
  PImage pic;
  PImage picR;
  Picture (float x, float y, float vx, float vy, int w, int h, String imagefilename, String imagefilenameR)
  {
    super(x,y,vx,vy,w,h); 
    pic = loadImage(imagefilename);
    picR = loadImage(imagefilenameR);
  }
  void show() {
    if (dx>0) {
        image(pic,bx,by,wdiam,hdiam);}
     else {
        image(picR,bx,by,wdiam,hdiam);
     }
  }
}