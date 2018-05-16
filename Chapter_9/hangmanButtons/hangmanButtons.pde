//Hangman buttons
//table of just 5 words
//should probably use monospace font for alphabet buttons
String[] wordlist;
Table words;
int numWords;
Boolean chosen = false;
String secret; //the current secret word
String blanks = "";   //will hold blanks, some of which are filled in with correct guesses
int wlen;  //length of secret word
int nGuessed;  //number of correct guesses
String msg = "Press any key to start";
int nextStep = 0;  //position in the hanging progression

Button[] buttons = {};
float padding = 8; //padding for letter within box in button

void setup() {
  size(1000,800);
  words = loadTable("words.csv");
  numWords = words.getRowCount();
  wordlist = new String[numWords];
  for (int i = 0;i<numWords;i++) {
    wordlist[i] = words.getString(i,0);
  }
  
  background(200);
  setupAlphabetButtons();
}
void setupAlphabetButtons() {
  String alphabet = "abcdefghijklmnopqrstuvwxyz";
  int startx = 20;
  int starty = 680;
  int buttonwidth = 26;
  int buttonheight = 22;
  int margin = 10;
  int spacing = margin + buttonwidth;
  for (int i=0;i<alphabet.length();i++) {
     Button b = new Button(startx+i*spacing,starty,buttonwidth,buttonheight,alphabet.charAt(i));   
     buttons = (Button[]) append (buttons,b);
  }
}

void resetAlphabetButtons() {
  for (int i=0;i<buttons.length;i++) {
    buttons[i].removed = false;
  }  
}

void showButtons() {
  for (int i=0;i<buttons.length;i++) {
     buttons[i].display();
  }
}

char whichLetter (int x, int y) {
     for (int i=0;i<buttons.length;i++) {
         if (buttons[i].isOver(x,y)) {
              return (buttons[i].letter);
         }
     }
     return ('?');  //no letter that has not been removed is pressed
}

void draw() {
  //most of display done elsewhere  
  if (!chosen) {
    fill(0);
    textSize(30);
    text(msg,20,30);
  }
}

void keyPressed() {
  if (!chosen) {  //pick a new secret word
    background(200);
    msg = "Press letter keys to guess letters";
    text(msg,20,30);
    secret = wordlist[int(random(numWords))];
    wlen = secret.length();
    chosen = true;
    blanks = "";
    nGuessed = 0;
    nextStep = 0;  
    for (int i=0;i<wlen;i++) {
      blanks = blanks + "_ ";
    }
    fill(0);
    text(blanks,30,100);
    advanceHanging();
    showButtons();
  }
} 

void mousePressed() {
   // determine which letter button pressed
   char letterpicked = whichLetter(mouseX,mouseY);
   if (letterpicked=='?') { return;} //don't count bad press as move   
     Boolean found = false;
     for (int i=0;i<wlen;i++){
       if (secret.charAt(i)==letterpicked) {
         nGuessed++;
         found = true;
         blanks = replace(blanks,letterpicked+" ",i*2,2);     
       }
     }  
     if (found) {
       //erase old blanks and display new
       fill(200);
       noStroke();
       rect(0,60,width,80);
       fill(0);
       text(blanks,20,100);
     }
     else {
       advanceHanging();
     }
     if (nGuessed>=wlen) {
       //erase old message and put in new one
       //set up for re-start
      noStroke();
      fill(200);
      rect(0,0,width,40);
      msg = "You won! Press any key for new game";
      resetAlphabetButtons();
      chosen = false;
      text(msg,20,30);
      nGuessed = 0;
      nextStep=0;
     }
  }
  

String replace(String base,String sub,int place,int remove){
   String prior = base.substring(0,place); //before insert
   String after = base.substring(place+remove); //after
   return prior+sub+after;
} 

void advanceHanging() {
  //println(" hanging advance ");
  switch (nextStep) {
    case 0:
     strokeWeight(6);
     stroke(153,76,0);   //brownish for gallows
     line(5,200,300,200);
     line(10,200, 10,600);
     line(5,600,120,600);
     break;
    case 1:  //head
      stroke(0);  //necessary because may be noStroke for erasing blanks
      strokeWeight(2);
      fill(255);
      ellipse(200,300,40,70);
      break;
    case 2:  //body
      stroke(0);
      line(200,335,200,450);
      break;
    case 3: //right arm
      stroke(0);
      line(200,350,240,380);
      break;
    case 4: //left arm
      stroke(0);
      line(200,350,160,380);
      break;
    case 5: //right leg
      stroke(0);
      line(200,450,220,550);
      break;
    case 6: //left leg
      stroke(0);
      line(200,450,180,550);
      break;
    case 7: //noose.  Set up for re-start
      stroke(255,128,22); //color for rope
      line(180,200,200,330);
      noFill();
      ellipse(200,340,30,10);
      fill(255);
      stroke(0);
      ellipse(200,300,40,70);
      //erase old message and put in new one
      noStroke();
      fill(200);
      rect(0,0,width,40);
      msg = "You lost! Press any key for new game";
      resetAlphabetButtons();
      chosen = false;
      text(msg,20,30);
      nGuessed = 0;
      nextStep=-1;
      break;
  }
  nextStep++;
}