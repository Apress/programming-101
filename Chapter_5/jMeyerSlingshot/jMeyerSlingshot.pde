Slingshot mySlingshot;
Rock myRock;
float rockD = 15; //diameter used for myRock
float horSpeed, verSpeed1, verSpeed2; //to simulate ballistic motion
float gravity = .05;  //arbitrary value designed to produce a nice arc
float adjust = 20;  //arbitrary scale factor on initial speeds
PImage chicken;
Picture chickenPicture;
PImage feathers;
Picture feathersPicture;

int targetIndex;
Boolean rockInMotion = false;  //rock is in motion in the sling and once released
Boolean slingInMotion = false;  // after mouse pressed on the rock and until mouse released
Thing[] scene = {};  //will hold all Thing objects to be displayed
class Thing {
  float tx;
  float ty;
  Thing (float x, float y) {
     tx = x;
     ty = y;
}
  void show() {
    // to be over ridden
  }
  void move(float dx, float dy) {  //moves are done incrementally, that is, arguments indicate changes
    tx = tx + dx;
    ty = ty + dy;
  }
} 
class Rock extends Thing {
  float rDiam;
  Rock (float x, float y, float diam) {
     super(x,y);
     rDiam = diam;
  }
  void show() {
     fill(200,0,200);
     ellipse(tx,ty,rDiam, rDiam);
    
  }
  Boolean isOver(float mx, float my) {
      return (dist(mx,my,tx,ty)<rDiam/2);
  }
  float getTx() {
    return tx;
  }
  float getTy() {
    return ty;
  }
}
class Slingshot extends Thing {
  float hx,hy;  //moving part of slingshot
  float f1x,f1y,f2x,f2y,bx,by;  //stationary part of slingshot, along with tx and ty
  //note: all variables are offsets from tx and ty
  Slingshot (float f1xa,float f1ya, float f2xa, float f2ya, float x, float y, float bxa, float bya, float hxa, float hya)
     {
       super(x,y);
       f1x = f1xa;
       f1y = f1ya;
       f2x = f2xa;
       f2y = f2ya;
       bx = bxa;
       by = bya;
       hx = hxa;
       hy = hya;
     }
     void show() {
       strokeWeight(4);
       line (tx, ty, tx+bx, ty+by);
       
       line (tx, ty, tx+f1x, ty+f1y);
       line (tx, ty, tx+f2x, ty+f2y);
       line (tx+f1x, ty+f1y, tx + hx, ty+hy);
       line (tx+f2x, ty+f2y, tx +hx, ty+hy);
     }
     float getActualHx() {
       return (tx+hx);
     }
     float getActualHy() {
       return (ty+hy);
     }
     void movePocket(float dx, float dy) {
       hx += dx;
       hy += dy;
     } 
     float getActualF1x() {
       return (tx+f1x);
     }
     float getActualF1y() {
       return (ty+f1y);
     }
     float[] initSpeeds() {  //returns an array with two values
        float actF1x, actF1y,actHx,actHy;
        float angle;
        float[] answer = {0,0};
        float lenOfSling;
        actF1x = getActualF1x();
        actF1y = getActualF1y();
        actHx  = getActualHx();
        actHy  = getActualHy();
        lenOfSling = dist(actF1x,actF1y,actHx,actHy)/adjust; // extension of sling, adjusted
        angle = -atan2(actF1y-actHy,actF1x-actHx);  //computes angle using vertical and horizontal differences
        answer[0] =  lenOfSling*cos(angle);
        answer[1] = -lenOfSling*sin(angle);  //adjust for upside down coordinates
        return answer;
     }
}
class Picture extends Thing {
   PImage pic;
   float picW;
   float picH;
   float padLeft;
   float padRight;
   float padTop;
   float padBot;
   
   Picture (float x, float y, PImage pica) {
     super(x,y);
     pic = pica;
     picW = pic.width;
     picH = pic.height;
     padLeft = x+picW/4;
     padRight = x+picW*.75;
     padTop = y+picH/4;
     padBot = y+picH*.75;
   }
   void show() {
     image(pic,tx,ty);
   }
   Boolean hits(float x, float y) {
     //return true if  x,y near center of picture
     return ((x>padLeft)&&(x<padRight)&&(y>padTop)&&(y<padBot));
   }
}

void setup() {
  size(1300,600);
  frameRate(25);  //slow down frames
  mySlingshot = new Slingshot(-10,-20, 10, -40, 170,400, 0,100, -90,-20);
  scene = (Thing[]) append(scene,mySlingshot);
  targetIndex = scene.length;  // will be used to swap in feathers Picture
  chicken = loadImage("chicken.gif");
  feathers = loadImage("feathers.gif");
  feathersPicture = new Picture(600,400,feathers);
  chickenPicture = new Picture(600,400,chicken);
  scene = (Thing[]) append(scene,chickenPicture);
  myRock = new Rock(mySlingshot.getActualHx(),mySlingshot.getActualHy(),rockD);
  scene = (Thing[]) append(scene,myRock);
  background(255);
  
}

void draw () {
  background(255);
  for (int i=0;i<scene.length;i++){  //show everything, that is, all thing objects in scene array
       scene[i].show();
  }
  
  if (rockInMotion) {
      if (chickenPicture.hits(myRock.getTx(),myRock.getTy()))
         {
           rockInMotion = false;
           scene[targetIndex] = feathersPicture;
         }
      simulateRockInAir();
      if (myRock.getTy()> height) {
         rockInMotion = false;
         noLoop();
      }
  }
  if (slingInMotion) {
    float dx = mouseX - pmouseX;  //determine changes
    float dy = mouseY - pmouseY;
   
    mySlingshot.movePocket(dx,dy);
    myRock.move(dx,dy);
    
  }
}

void mousePressed() {
  if (!rockInMotion) {
    if (!slingInMotion) {
       if (myRock.isOver(mouseX,mouseY)) { //only do something if mouse is over the rock
           slingInMotion = true;
           
       }
    }
  }
}
void mouseReleased() {
  if (slingInMotion) {
    slingInMotion = false;
    calculateSpeeds();
    rockInMotion = true;  
  }
}

void calculateSpeeds() {
   float[] speeds = mySlingshot.initSpeeds();
   
   horSpeed = speeds[0];
   verSpeed1 = speeds[1];
   //print("horSpeed is "+horSpeed+" verSpeed1 is "+verSpeed1);
}
void simulateRockInAir() {
   float dy;
   verSpeed2 = verSpeed1 + gravity;
   dy = (verSpeed1 + verSpeed2)/2; 
   //print("in simulateRockInAir, horSpeed is "+horSpeed+" vertical change is "+dy);
   myRock.move(horSpeed,dy);
   verSpeed1 = verSpeed2;  //prepare for next iteration
}