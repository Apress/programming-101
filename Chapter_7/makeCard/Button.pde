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

class FontButton extends Button {
  PFont ft;
  FontButton (int x,int y,int bwid,int bht,color c, String lab, PFont fta) {
    super(x,y,bwid,bht,c,lab);
    ft = fta;
  }
  void display() {
    textFont(ft);
    super.display();
  }
}