// coin flip
PImage coinh,coint;
PFont font;
int headc,tailc;
void setup() {
   size(600,400);
   headc = 0;
   tailc = 0;
   font = createFont("Ariel",20);
   textFont(font);
   coinh = loadImage("smirk.JPG");
   coint = loadImage("braid.jpg");
   fill(0,0,240);
   text("Click on the screen.",100,100);
}
void draw() {
}
void mouseReleased() {
   background(255);  //change background to white
   if (.5<random(1)){
        image(coinh,mouseX,mouseY,100,100);
        headc = headc+1;
      }
   else {
        image(coint,mouseX,mouseY,100,100);
        tailc = tailc+1;
      }
//   fill(0,0,240);    //change color for subsequent text to blue
   text("Heads ",10,20);
   text(headc,10,50);
   text(" Tails ",80,20);
   text(tailc,80,50);  
}