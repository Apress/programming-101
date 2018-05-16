String[] fontList ;
PFont myfont;
void setup() {
size(800, 600);
fill(255,0,0);
fontList =  PFont.list();
 println(fontList);
}

void draw() {
 }
 
void mousePressed() {
    int ch = int(random(0,fontList.length));
    myfont = createFont(fontList[ch],20);
    textFont(myfont);
   text(fontList[ch],mouseX,mouseY);
   
  }