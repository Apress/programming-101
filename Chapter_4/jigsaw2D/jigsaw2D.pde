// rectangular jigsaw: creating pieces by
//breaking up rectangular picture by horizontal
//and vertical lines
Piece[] pieces;
PImage original;
PImage originalA;
int phase = 0;
Button[] buttons;
int NHor = 4;
int NVer = 3;
int NoP = NHor * NVer;
float oriWidth;
float oriHeight;
float oriRatio;
int adjustedWidth;  //adjusted dimensions to fit within (.75) of screen dimensions
int adjustedHeight;
int wedgeW;
int wedgeH;
int pieceMoving = -1;
int offsetx;
int offsety;
int tolerance = 20;
int travelBackFrames;
int[] deltaxs = new int[NoP];  //hold amount of horizontal change in Restore animation. Computed in mouseClicked
int[] deltays = new int[NoP];  //hold amount of vertical change in Restore animation.  Computed in mouseClicked
void setup(){
  frameRate(30);
  travelBackFrames = 30*2;
  original = loadImage("cubaOldCarR.jpg");
 
  size(displayWidth,displayHeight);
 
  oriWidth = original.width;
  oriHeight = original.height;
  oriRatio = oriHeight/oriWidth;
  adjustedWidth = round(min(.75 * displayWidth,oriWidth));
  adjustedHeight = round(min(oriRatio * adjustedWidth,.75*displayHeight));
  adjustedWidth = round(adjustedHeight/oriRatio);
  //println("adjustedWidth is ",adjustedWidth,"and adjustedHeight is",adjustedHeight);
  wedgeH = round(adjustedHeight/NVer);
  wedgeW = round(adjustedWidth /NHor);
  originalA = createImage(adjustedWidth,adjustedHeight,RGB);
  originalA.copy(original,0,0,round(oriWidth),round(oriHeight),0,0,adjustedWidth,adjustedHeight);
  makeButtons();
  makePieces();
}

void makeButtons()
{
  buttons = new Button[2];
  buttons[0] = new Button(50,30,80,40,color(200,0,0),"Mix up");
  buttons[1] = new Button(200,30,80,40,color(0,100,0),"Restore");
}

void drawButtons()
{
  for (int i=0;i<buttons.length;i++)
  {
      buttons[i].display();
  }
}

void mouseClicked()
{
 // function "knows" what button does what
 int mx, my;
 mx = mouseX;
 my = mouseY;
 if (buttons[0].isOver(mx,my))
    {
      mixUpPieces();
      phase = 0;
    }
 if (buttons[1].isOver(mx,my))
    {
      phase = 2;
      //set up for to re-form original
      
      for (int i=0;i<NoP;i++)
       {
         deltaxs[i] = floor(((100.0 + pieces[i].locx) - pieces[i].px)/travelBackFrames);
         deltays[i] = floor(((100.0 + pieces[i].locy) - pieces[i].py)/travelBackFrames);
       }
    }
  
}
void mousePressed()
{
  int mx = mouseX;
  int my = mouseY;
  for (int i=0; i<NoP;i++)  //will stop at first piece the mouse is over
    {
      if (pieces[i].isOver(mx,my))
        {
          pieceMoving = i;
          //offsetx and offsety set in isOver method
          break;
        }
    } 
    //no effect if mouse NOT over any piece
}

void mouseDragged()
{
  if (pieceMoving>= 0)
  {
     pieces[pieceMoving].px= mouseX - offsetx;
     pieces[pieceMoving].py= mouseY - offsety;
    
  }
}

void mouseReleased()  //checks if puzzle complete, that is all pieces roughly in position
                      // relative to first piece
{
  
  pieceMoving = -1;
  //determine position of first piece
  int firstx = pieces[0].px;
  int firsty = pieces[0].py;
  boolean oksofar = true;  //assume things are okay. if any one piece not close enough change to false
  for (int i=1;i<NoP;i++)
    {
      int pxi = pieces[i].px;
      int pyi = pieces[i].py;
      int perfectpx = firstx + pieces[i].locx;
      int perfectpy = firsty + pieces[i].locy;
      int errorx = abs(perfectpx-pxi);
      int errory = abs(perfectpy-pyi);
      if ((errorx>tolerance) || (errory>tolerance))
       { oksofar = false;
       
       break;
       }
    } 
  if (oksofar)  //only do something if pieces in place.
   {
     
     text("Close enough.You can click Restore or Mix up to try again.",500,20);
     phase = 1;
     
   }
}

void makePieces()  //the Piece constructor will cut out the piece
{
  pieces = new Piece[NoP];
  int alli = 0; // index for populating pieces
  for (int i=0;i<NHor;i++)
  for (int j=0;j<NVer;j++)
  {                    // initial positions is determined randomly
    int rx = round(random(.75*displayWidth));
    int ry = round(random(.75*displayHeight));
   
    pieces[alli] = new Piece(wedgeW*i,wedgeH*j,rx,ry,wedgeW,wedgeH);
   
    pieces[alli].display();
    alli++;   
  }
}
void mixUpPieces()  //start off puzzle by re-locating pieces in random positions
{
  for (int i=0;i<NoP;i++)
    {
      int rx = round(random(.75*displayWidth));
      int ry = round(random(.75*displayHeight));
      pieces[i].px=rx;
      pieces[i].py=ry;
    }
  
}

void draw()
{   // does different things in different phases 
  
  if (phase == 0)  //player may have moved pieces
  {
    background(255);
    drawPieces();
    drawButtons();
  }
  if (phase == 2)   // phase when pieces slowly move into position
  {
    for (int i=0;i<NoP;i++)
      {
        
        pieces[i].px=pieces[i].px+deltaxs[i]  ;  // the deltaxs and deltays have been set in
        pieces[i].py=pieces[i].py+deltays[i]  ;  // mouseClicked when the Restore button was clicked
      } 
    background(255);
    drawPieces();
    drawButtons();
     if (abs(pieces[0].px-100)<5*tolerance)
    //if (abs(pieces[0].px-100)<.5*tolerance)  //if first piece is close enough in x, restore dance 
                                         // is ended. All pieces adjusted to the correct position
    
      {
        for (int i=0;i<NoP;i++)
        {
        pieces[i].px=100+pieces[i].locx;
         pieces[i].py=100+pieces[i].locy;
        }
        phase = 0;  // phase reset to 0. player needs to click on mix up
        
       
      }
     
  }
 
}

void drawPieces()  // loop through and display all pieces
{
  for(int i=0;i<NoP;i++)
    {
     pieces[i].display();
     
    } 
  
}



class Button
{
  int cx,cy;  //center 
  int bw, bh, bwsq, bhsq; 
  color col;
  String label;
  
  Button (int x,int y,int bwid,int bht,color c, String lab)
  {
    cx = x;
    cy = y;
    bw = bwid;
    bh = bht;
    bwsq = bw*bw;
    bhsq = bh*bh;
    col = c;
    label = lab;
  }
  boolean isOver(int x,int y)  //isOver uses formula for ellipse
  {
    float disX = cx - x;
    float disXsq = disX * disX;
    float disY = cy - y;
    float disYsq = disY * disY;
    float v = (disXsq / bwsq) + (disYsq/bhsq);
    return (v<1);

  }
  void display()  //draw ellipse for button and then label
  {
     fill(col);
     ellipse(cx,cy,bw,bh);
     fill(0);
     textAlign(CENTER,CENTER);
     text (label,cx,cy);
  }
}

class Piece
{
  int locx;  //x position in originalA
  int locy;  //y position in originalA
  int px;    //location on the screen. Will change
  int py;    // location on the screen. Will change
  int pw;    //width of piece. All the same in this program, but keep for future applications
  int ph;    //height of piece. All the same in this program, but keep for future applications.
  PImage content;
  Piece (int locxC, int locyC, int x, int y, int w, int h)
  {
    locx = locxC;
    locy = locyC;
    px = x;
    py = y;
    pw = w;
    ph = h;
    content = createImage(pw,ph,RGB);
    content.copy(originalA,locxC,locyC,pw,ph,0,0,pw,ph);  // copy over part of originalA
   // println("locx of ",locx," and locy ",locy);
  }
  boolean isOver(int mx,int my)  //checks if parameters, presumably mouse position
                                 // indicate it is over this piece
  {
    if ((mx>=px) && (mx<=(px+pw)) && (my>=py) && (my<(py+ph)))
      {
        offsetx = mx - px;  //compute offsets so drag proceeds smoothly
        offsety = my - py;
        return true;
      }
    else      //not over
      {
         return false;
      }
  }
  void display()  // display this piece on screen
  { 
    image(content,px,py,pw,ph);
    
  }
  

}