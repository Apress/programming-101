class Item {
  float xpos;
  float ypos;
  float iwidth;
  float iheight;
  int cred;
  int cgreen;
  int cblue;
  
  Item(float x,float y,float w,float h,int red,int green, int blue) {
    xpos = x;
    ypos = y;
    iwidth = w;
    iheight = h;
    cred = red;
    cgreen = green;
    cblue = blue;
  }
  
   Boolean isOver(float x,float y) {   
     return ((x>xpos)&&(y>ypos)&&(x<(xpos+iwidth))&&(y<(ypos+iheight))); 
  }
  void removeIt(int i) {
    removeFromItemsArray(i);   
  } 
  void display() {
    fill(cred,cgreen,cblue);
    rect(xpos,ypos,iwidth,iheight);
  }
  
  void move(float dx,float dy) {
     xpos +=dx;
     ypos +=dy;
  }
  void duplicate() {
    Item copy;
    copy = new Item(xpos+10, ypos+10,iwidth,iheight,cred,cgreen,cblue);
    items = (Item[]) append(items,copy);
  } 
  void restart() {
    // no action for Item. 
   }
 void pauseMovie() {
   //no action for Item
 }
}


  
 
class MovieItem extends Item {
  //inherits position and dimension variables, colors set to a default. Adds 2 variables
   
   Movie imovie;
   String movieFileName;
   PApplet paref;   
   MovieItem (float x,float y,float w,float h,  String mfn, PApplet par ) {
     //call parent constructor to set base variables
     super(x,y,w,h,255,255,255);  //sets up white rectangle
     imovie = new Movie(par,mfn);
     movieFileName = mfn;
     paref = par;
     imovie.loop();   
  }
  void removeIt(int i) {
    imovie.stop();
    imovie = null;  //extra precaution to remove link to movie, for garbage collection
    super.removeIt(i);   
  }
  
  void duplicate() {
    Item copy; 
    copy = new MovieItem(xpos+10, ypos+10,iwidth,iheight,movieFileName,paref);
    items = (Item[]) append(items,copy);
  } 
  
  void display() {
     image(imovie, xpos, ypos,iwidth,iheight);
  }
  
  void restart() {
     imovie.jump(0);
     imovie.loop();
  }
  
  void pauseMovie() {
    imovie.pause();
  }
} 

class ImageItem extends Item {
  //inherits position and dimension variables, colors set to a default. Adds one variable  
   PImage myImage;
   String filename;
   
   ImageItem (float x,float y,float w,float h, String imagefilename) {
     //call parent constructor to set base variables
     super(x,y,w,h,255,255,255);  //sets up white rectangle
     filename = imagefilename;
     myImage = loadImage(imagefilename);   
  }
  
  void duplicate() {
    Item copy;
    copy = new ImageItem(xpos+10, ypos+10,iwidth,iheight,filename);
    items = (Item[]) append(items,copy);
  } 
  
  void display() {
     image(myImage, xpos, ypos,iwidth,iheight);
  }
} 
  