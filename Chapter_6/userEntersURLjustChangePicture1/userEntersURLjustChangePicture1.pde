//acquire image online at specific url.

PImage original;
PImage grayed;
Boolean nowOrig = false;
float rfactor = 0.2980;
float gfactor = 0.5870;
float bfactor = 0.1140;
String myText = "";
String answer = "";
String prompt ="Type in web address\n";
String url = "";
int imgw;
int imgh;
int imgw2;
int imgh2;

void setup() {
  size(800,800);
  textSize(20);
  fill(0);
}

void getImage() {
  original = loadImage(url);
  if (original !=null) {
    imgw = original.width;
    imgh = original.height;
    grayed = createImage(imgw,imgh,RGB);
   // grayed.copy(original,0,0,imgw,imgh,0,0,imgw,imgh);
    imgw2 = 2*imgw;
    imgh2 = 2*imgh;
    image(original, 0,0,imgw2,imgh2);
    makeGray();
    image(grayed,imgw2+10,0,imgw2,imgh2);
    text("Press any key to toggle between original and grayscale",20,imgh+50);
    fill(200,0,0);
    ellipse(100,700,100,100);
    fill(0,200,0);
    ellipse(600,700,150,150);
}
  else {
    myText = "";
    answer="";
    background(200);
    prompt = "Bad address for image. Try again.\n";
  }
}

void draw() { 
  if (original==null) {
    background(200);
    text(prompt+myText,100,100);
    if (answer.length()>0) {
      url=answer;
      getImage();     
    }
   }
}

void keyPressed () {
  if (original!=null) {
    toggle();
  }
  else {
    getTextInput();
  }  
}

void makeGray() {
    original.loadPixels();
    grayed.loadPixels();
    for(int i=0;i<original.pixels.length;i++) {
     float redc = red(original.pixels[i]);
     float greenc = green(original.pixels[i]);
     float bluec = blue(original.pixels[i]);
     float gs = redc*rfactor+greenc*gfactor+bluec*bfactor;
     color gscolor = color(gs,gs,gs);
     grayed.pixels[i] = gscolor;
    }
    grayed.updatePixels(); 
}

void toggle() {
  if (nowOrig) { 
    image(original,0,0,imgw2,imgh2);
    nowOrig = false;
  //  println("did original");
    }
    else {  //already changed original
      image(grayed,0,0,imgw2,imgh2);
   //   println("grayed");
      nowOrig = true;
    }
 }

void getTextInput() { 
   if (keyCode == BACKSPACE) {
     if (myText.length() > 0 ) {
       myText = myText.substring( 0 , myText.length()- 1 );
     }
   } else if (keyCode == DELETE) {
     myText = "" ;
   } else if (keyCode == ENTER) {
     answer = myText;
   } else if (keyCode != SHIFT && keyCode != CONTROL && keyCode != ALT) {
     myText = myText + str(key);
   } 
}