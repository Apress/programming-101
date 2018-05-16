//acquire image online at specific url.
//pick font
//write message

PImage original;

String myText = "";
String answer = "";
String prompt ="Type in web address for the picture\n";
String promptF = "Name a font. \n";
String promptM ="Write your message.\n";
String url = "";
String fontName = "";
float imgw;
float imgh;
float aspect;

PFont myFont;
String message = "";
PFont firstFont;

void setup() {
  size(800,800);
  firstFont = createFont("Arial",20);
  textFont(firstFont);
  fill(0);
}



void draw() { 
  if (original==null) {
    text(prompt+myText,10,100);
    if (answer.length()>0) {
      url=answer;
      getImage();     
    }
  }
  else if (myFont==null) {
    text(promptF+myText,20,500);
    if (answer.length()>0) {
       fontName = answer;
       answer = "";
       myText="";
       setFont();
    }
  }
  else if (message.length()<1) {
    text(promptM+myText,20,700);
    if (answer.length()>0) {
      message = answer;
      displayAll();
    }
  }
}

void keyPressed() {
  getTextInput();
  
  
}

void getImage() {
  original = loadImage(url);
  if (original !=null) {
    background(200);
    imgw = original.width;
    imgh = original.height;
    aspect = imgw/imgh;
    imgh = min(imgh,400);  //resize as needed
    imgw = imgh * aspect;  //won't change if imgh didn't change
    image(original, 0,0,imgw,imgh);
    myText = "";
    answer = "";
  }
  else {
    myText = "";
    answer="";
    background(200);
    text("Bad address for image. Try again.",20,30);
  }
}

void setFont() {
  myFont = createFont(fontName,30);
  //need to put in error check for bad font
  if (myFont==null) {
     myText = "";
    answer="";
    background(200);
    image(original,10,10,imgw,imgh);
    text("Bad font name. Try again.\n",20,500);
  }
  
}

void getMessage() {
  if (answer.length()>0) {
    message = answer; 
   }
}

void displayAll() {
  background(200);
  image(original,10,10,imgw,imgh);
  textFont(myFont);
  text(message,10,imgh+50);
  text("Down arrow to take snapshot. Up arrow to re-start.",10,imgh+150); 
}


void getTextInput() { 
   if (keyCode == UP) {
     original = null;
     myFont = null;
     message = "";
     myText="";
     answer = "";
     textFont(firstFont);
     background(200);
   }
   else if (keyCode == DOWN) {
     saveFrame("snaps/card####.png");
   }
   else 
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