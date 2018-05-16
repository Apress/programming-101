//classy bouncing balls

Ball[] balls = {};

void setup() {
   balls = (Ball[]) append(balls,new Ball(width/2,width/2,3,3,20));
   balls = (Ball[]) append(balls,new Ball(width/4,width/3,2,1,40));
   balls = (Ball[]) append(balls,new Ball(width*.75,width/6,1,2,60));
   size (900,600);
  
}
void draw(){
  background(0); //erase window
  for (int i=0;i<balls.length;i++) {
    balls[i].moveAndShow();
  }
  
}

class Ball {
   float bx;
   float by;
   float dx;
   float dy;
   int balldiam;
   
   Ball (float x, float y, float vx, float vy, int diam) {
     bx = x;
     by = y;
     dx = vx;
     dy = vy;
     balldiam = diam;
   }
   void moveAndShow() {
      ellipse(bx,by,balldiam,balldiam);
      bx = bx + dx;
      by = by + dy;
      if ((bx>=width) || (bx<=0)) {dx = -dx;}
      if ((by>=height) || (by<=0)) {dy = -dy;}
   }  
}