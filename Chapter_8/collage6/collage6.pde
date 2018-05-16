import processing.video.*;

Item[] items = {};
Item curItem = null;

void setup() {
  size(1000, 1000);
  
  Item myItem1 = new Item(10,30,100,200,250,0,200);
  items = (Item[]) append(items,myItem1);
  Item myItem2 = new Item(500,800,200,100,0,100,100);
  items = (Item[]) append(items,myItem2);
  MovieItem myMovieItem = new MovieItem(250,200,300,200,"snowman.mov",this);
  items = (Item[]) append(items,myMovieItem);
  ImageItem myImage1 = new ImageItem(10,500,205,154,"pigtails1.JPG");
  items = (Item[]) append(items,myImage1);
  ImageItem myImage2 = new ImageItem(600,300,300,400,"climbing.jpg");
  items = (Item[]) append(items,myImage2);
}

void draw() {
  //clear screen, display key commands, display all the items in order
  background(255);
  text("c for copy, d for delete, t for move to top, p for pause video, r for restart.",5,20);
  for (int i=0; i<items.length;i++){
    items[i].display();  //use appropriate method
  }
}

int overWhich() {  //find first item that mouse is over
  for (int i=0; i<items.length;i++) {
    if (items[i].isOver(mouseX,mouseY)) {
       return i;
     }
    }
   return -1;   
}

void keyPressed() {  //determine which if any item under mouse. Then determine key
  int i;
  i = overWhich();
  if (i < 0) {
    return;
  }
  else {
    //note: switch requires character
    switch(key) {
      case 'c':  //copy item at ith position and add to items array
         items[i].duplicate();
         break;
      case 'd':  //delete ith element from items array
         items[i].removeIt(i);
         break;
      case 't':  // swap ith element with the last element of the array, so it is on top
         swapThem(i,items.length-1);
         break;
     case 'r':  //restarts movie. No action for other items. Work around for shallow copying of movies followed by delete.
        items[i].restart();
         break;
     case 'p':
         items[i].pauseMovie();
         break;
      default:
         println("invalid key pressed");
         break;
    }
  }
}

void swapThem(int j,int k) {  //general function but used only to get item to last position
  Item temp;
  temp = items[j];
  items[j] = items[k];
  items[k] = temp;
  
  
}
void removeFromItemsArray(int i) {
  //the ith item is removed from items. It still exists. Perhaps garbage collection removes it
  //note any movie has been stopped.
  Item[] tempitems = new Item[items.length-1];
  
  for (int k = 0; k<i;k++) {
      tempitems[k] = items[k];
  }
  for (int k=i+1;k<items.length;k++) {
      tempitems[k-1] = items[k];
  }
  items = tempitems;
  
}

void mousePressed() {
  // find out if on any item
  int i;
  i = overWhich();
  if (i>=0) {
       curItem = items[i];  
  }  
  
}

void mouseDragged() { 
   float dx;
   float dy;
   if (curItem!=null) {
     dx = mouseX - pmouseX;  
     dy = mouseY - pmouseY;  
     curItem.move(dx,dy);
   }
  
}

void mouseReleased(){
    curItem = null;
}

// Called every time a new frame is available to read
void movieEvent(Movie m) {
  m.read();
}