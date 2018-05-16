class Button {
  int bx;
  int by;
  int bw;
  int bh;
  char letter;
  Boolean removed;
  

  
   Button (int tx, int ty, int tw, int th, char let) {
      bx = tx;
      by = ty;
      bw = tw;
      bh = th;
      letter = let;
      removed = false;
   }
  
   Boolean isOver (int x, int y) {
     if (removed) {return false;}
     if ((x>=bx)&&(x<=(bx+bw))&&(y>=by)&&(y<=(by+bh)))
        { 
          removed = true;
          //remove this button by drawing over it
          noStroke();
          fill(200);
          rect(bx,by,bw+3,bh+3);  //extra is to erase borders
          return true;
        }
     else {return false;}   
   }
  void display () {
    
      strokeWeight(1);
      stroke(0);
      fill(250,0,0);
      rect(bx,by,bw,bh);
      fill(0);
      textSize(20);
      text(letter,bx+padding,by+2*padding+1);
   
  }
 }