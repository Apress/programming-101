// basic snake game: a snake, made up of segments, travels around and consumes food, growing one segmnt
//  with each food item. The arrow keys direct the motion.
//You can think of the game as taking place in grid of unit size cells.
//Jeanine Meyer
// use of arrow keys
//classes for snake segments and for food items.
//use of ArrayList for list of Food objects (and array for segments of snake
//Game ends when snake collides with itself or goes off screen or exceeds time limit (use of millis for timing)
float margin = 10;
float cw;
float ch;
int unit;


int timeLimit = 30*1000; //30 seconds for game
int timeStart;
int score = 0;
ArrayList<Food> foods = new ArrayList<Food>();  //Arraylists of objects provide way to remove elements
int amountOfFood = 30;
Seg[] segs;
HeadSeg hseg;


void setup() {
   size(800,600);
   cw = width;
   ch = height;
   unit = int(min(cw,ch)/30);
   ellipseMode(CORNER);  //easier to check for snake over circle representing food
   placefood();
   buildfirstsegments(5);
   //store starting time. Time check done in draw.
   timeStart = millis();

}

void endgame(String m) {
   fill(0);  //set for the message
   textSize(30);
   int snakeL = segs.length;
   text("Game Over: "+m+" Snake size is "+str(snakeL),100,100);
   noLoop();  //stop action: keys no longer work.
}

void draw() {
  background(200);  //clear screen
  //display food, then snake, then check time.
  // the foods ArrayList elements are accessed using the get method.
  for (int i=0;i<foods.size();i++) {
    foods.get(i).display();
  }
  //sets is an array of Seg objects
  for (int i=0; i<segs.length;i++) {
    segs[i].display();
  }
  
 //determine elapsed time since sketch started
  if (timeLimit<(millis()-timeStart)) {
    endgame("Time.");
  }
}

void placefood() {
  //Populate ArrayList of Food objects. Note use of add.
  for (int i=0;i<amountOfFood;i++) {
    foods.add(new Food(unit*int(random(width)/unit),unit*int(random(height)/unit)));
  }
}

void buildfirstsegments(int n) {  
  //position head randomly on screen, but not close to edges
  int leftbd = unit*10;
  int rightbd = width-leftbd;
  int headx = unit*int(random(leftbd,rightbd)/unit);
  int heady = unit*int(random(leftbd,rightbd)/unit);
  Seg aseg;
  hseg = new HeadSeg(headx,heady);
  segs = new Seg[n];  //create array of the indicated size and then assign individual elements
  segs[0] = hseg;
  for (int i=1;i<n;i++) {
    int nsegx = headx+(i*unit);  //snake starts out horizontal, with head seg on the left.
    int nsegy = heady;
    aseg= new Seg(nsegx,nsegy);
    segs[i] = aseg;
  }
}

void keyPressed() {
  switch(keyCode) {
    case UP: 
        movesnake(0,-unit);
        break;
    case DOWN: 
        movesnake(0,unit);
        break;
    case RIGHT: 
        movesnake(unit,0);
        break;
    case LEFT: 
        movesnake(-unit,0);
        break; 
  }
  
}

void movesnake(int dx, int dy) {
  //need to slide snake along
  int numOfSegs = segs.length;
  int[] xpositions = new int[numOfSegs];
  int[] ypositions = new int[numOfSegs];
  //store current positions in the two arrays. Will not use last values
  for (int i=0;i<numOfSegs;i++) {
    xpositions[i] = segs[i].sx;
    ypositions[i] = segs[i].sy;
  }
  //determine new position for head segment
  int newHeadx = xpositions[0]+dx;
  int newHeady = ypositions[0]+dy;
  segs[0].moveTo(newHeadx,newHeady); //first seg moves to calculated positions
  for (int i=1;i<numOfSegs;i++) {  //move into place of preceeding seg
    segs[i].moveTo(xpositions[i-1],ypositions[i-1]);
  }
  //check for head seg collisions with any segment, except last
  for (int i=1;i<(numOfSegs-1);i++) {
    if (closeEnough(newHeadx, newHeady, xpositions[i],ypositions[i])) {
      endgame("Collision with self.");
    }
  }
  //check if out of bounds
  if ((newHeadx<0)||(newHeadx>(width-unit))||(newHeady<0)||(newHeady>(height-unit))) {
    endgame("Out of bounds. ");
  }
  //see if over food
  for (int i=foods.size()-1;i>=0;i--) {  //iterates over the foods arraylist backwards
    if (closeEnough(newHeadx,newHeady,foods.get(i).fx,foods.get(i).fy)) {
      foods.remove(i);  //remove is available for ArrayList
      growSnake();
    }
  }
}
void growSnake() {
  int numOfSegs = segs.length;
  //needs to look at last 2 segments to get where to put new segment
  int lastx = segs[numOfSegs-1].sx;
  int lasty = segs[numOfSegs-1].sy;
  int overx = segs[numOfSegs-2].sx;
  int overy = segs[numOfSegs-2].sy;
  //the next element is the same as the last in x or y, but these expressions always work.
  int difx = lastx-overx;
  int dify = lasty-overy;
  int newx = lastx+difx;
  int newy = lasty+dify;
  Seg newseg = new Seg(newx, newy);
  segs = (Seg[])append(segs,newseg);
  
}
Boolean closeEnough(int x1,int y1,int x2,int y2) {
  return (dist(x1,y1,x2,y2)< margin);
}

class Seg {
  int sx;
  int sy;
  Seg (int x, int y) {
     sx = x;
     sy = y;
  
  }
  void display() {
    fill(0,250,0);
    rect(sx,sy,unit, unit);
  }
  void moveTo(int nx, int ny) { //move to this new position
    sx = nx;
    sy = ny;
  }

}

class HeadSeg extends Seg {
    HeadSeg(int x, int y) {
      super(x,y);
    }
    void display() {  //the head segment is displayed with a circle on top of a rectangle
      fill(0,250,0);
      rect(sx,sy, unit, unit);
      fill(0,0,200);
      ellipse(sx+.2*unit, sy+.2*unit, .60*unit,.60*unit);
    }
}
class Food {
   int fx;
  int fy;
  Food (int x, int y) {
     fx = x;
     fy = y;
  
  }
  void display() {
    fill(250,250,0);
    ellipse(fx+.1*unit,fy+.1*unit,.8*unit, .8*unit);
  }
}