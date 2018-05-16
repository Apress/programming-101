//make card by selecting from file on computer, then picking from a random set of 3 fonts, then entering in a message
//option to take a snapshot of the screen.

import java.io.File;
import processing.sound.*;

SoundFile shutter;
PImage original;
float imgw;
float imgh;
float aspect;
String[] fontList;
String[] myListOfFontNames = new String[3];
//PFont[] myListOfFonts = new PFont[3];
PFont chosenFont;
FontButton[] fontButtons = new FontButton[3];
Boolean fontButtonsBuilt = false;
String prompt="Your message: ";
String myText = "";
String answer = "";
String message = "";
PFont firstFont;
Boolean okay = false;

void setup()  {
  size(900,800);
  shutter = new SoundFile(this,"camera-shutter-click-01.wav");
  firstFont = createFont("Arial",30);
  textFont(firstFont);
  fill(0);
  text("Make a card by choosing a picture, then a font, then a message.\n Click down arrow to take a snap. Reload to try again.",10,50);
  fontList = PFont.list();
  selectInput( "Select an image", "imageChosen" );  //prompt does not appear
}

void buildFontButtons() {
  for (int i=0;i<3;i++) {
      int ch = int(random(0,fontList.length));
      PFont ft = createFont(fontList[ch],25);
      myListOfFontNames[i] = fontList[ch];
      fontButtons[i] = new FontButton(260,500+i*60,400,50,color(200,0,100),fontList[ch],ft);
      fontButtons[i].display();
    }
  
}

void draw() {
  if (okay) {
  if (original!=null) {
    background(200);
    image(original,10,10,imgw,imgh);
   
   if (!fontButtonsBuilt) {
     buildFontButtons();
     fontButtonsBuilt = true;
     noLoop();
   }
   else {  // won't be back in draw until a mouseClick on a font button
     text(prompt+myText,100,imgh+100);
     if (answer.length()>0) {
       message = answer;
       displayAll();
     }
   }
  }
  }
}

void displayAll() {
  background(200);
  image(original,10,10,imgw,imgh);
  text(message,30,imgh+50);
  noLoop();
}

void imageChosen( File f ) {
  if( f.exists() ) {
    original = loadImage( f.getAbsolutePath() ); 
    imgw = original.width;
    imgh = original.height;
    aspect = imgw/imgh;
  
    imgh = min(imgh,400);  //resize as needed
    imgw = imgh * aspect;  //won't change if imgh didn't change
  
    background(200);
    image(original, 10,10,imgw,imgh);
    okay = true;
  }
}

void mouseClicked() {
 
  for (int i=0;i<3;i++) {
    if (fontButtons[i].isOver(mouseX,mouseY)) {
      chosenFont = fontButtons[i].ft;
      textFont(chosenFont);
      textAlign(LEFT);
      break;
    }
  }
  loop();
 
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


void keyPressed() {
    
  if (keyCode == DOWN) {
    shutter.play();
     saveFrame("snaps/card####.png");
   }
  else {
  getTextInput();
  }
  
}