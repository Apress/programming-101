//acquire image online at specific url.
//whole window turned to grayscale. No change in original image

PImage original;
Boolean nowOrig = true;
float rfactor = 0.2980;
float gfactor = 0.5870;
float bfactor = 0.1140;

String myText = "";
String answer = "";
String prompt ="Type in web address\n";

String url = "";
int imgw;
int imgh;

void setup() {
  size(800,800);
  textSize(20);
  fill(0);
}

void getImage() {
  original = loadImage(url);
  if (original !=null) {
    background(200);
    imgw = 2*original.width;
    imgh = 2*original.height;
    image(original, 0,0,imgw,imgh);
     text("Press any key to toggle between original and grayscale",20,imgh+50);
  }
  else {
    myText = "";
    answer="";
    background(200);
    text("Bad address for image. Try again.",20,30);
  }
}

void draw() { 
  if (original==null) {
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
void toggle() {
  if (nowOrig) {
    loadPixels();
    for(int i=0;i<pixels.length;i++) {
     float redc = red(pixels[i]);
     float greenc = green(pixels[i]);
     float bluec = blue(pixels[i]);
   //  float gs =  redc*.3+greenc*.59+bluec*.11;
     float gs = redc*rfactor+greenc*gfactor+bluec*bfactor;
     color gscolor = color(gs,gs,gs);
     pixels[i] = gscolor;
    }
    updatePixels();
    nowOrig = false;
  }
  else {
    image(original,0,0,imgw,imgh);
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