/* @pjs preload="AnnikasInTree.jpg";  */


// demonstration for using, adding to, and saving a table
// the program displays an image for a set amount of time, 2 seconds.
// it then asks a question, to which the player keys in an answer
// when the answer is set (by a return key), the answer is stored in the table
// as a new row.
// the answer is also checked using the correctanswers string.
// this particular one checks for 10 or ten or Ten.
// After the storing and checking, the player can play again by clicking on the screen.
//The only way to end is to close the screen or click on stop in Processing.

Table results;  //hold table read in, and updated
PImage picture;  //holds the image that is the prompt for the question
int startTime;   // set in setup and mouseClicked
int duration = 4*1000;  //amount of time that image is displayed
float pictureWidth;   //used to calculate aspectWoverH
float pictureHeight;  // used to calculate aspectWoverH
float setHeight = 900;  //set height to display image
float computedWidth;  //calculated from the setHeight and aspectWoverH
float aspectWoverH;  //calculated from original values

String prompt="What did you see? ";
String myText = "";  //added to in keyPressed
String answer = "";  //set in keyPressed when return is given
String correctanswers = "(10)|(ten)|(Ten)";  //this is what is called a regular expression
 
void setup() {
  picture = loadImage("AnnikasInTree.jpg");
  pictureWidth = picture.width;
  pictureHeight = picture.height;
  aspectWoverH = pictureWidth/pictureHeight;
  computedWidth = setHeight * aspectWoverH;

  results = loadTable("results.csv","header");  //rows will be added to the table
  size(1000,1000);
  startTime = millis();  // current time will be compared to this plus duration
  textSize(20);
 
}

void draw() {  //either displaying image, asking for response, or writing for click to re-start
  background(0);
  if ((millis()-startTime)< duration) {  //keep displaying image
    image(picture,10,10,computedWidth,setHeight);
  }
  else {  //ask question
  
    text(prompt + myText,100,100);
     //keyPressed builds up the input in myText and then puts it in answer
    if (answer.length()>0) {
       
        storeAnswer();
        noLoop();  //stops looping until mouseClicked re-starts process
        }
   }
}

void keyPressed() {  //standard way to accept keyboard input
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

void storeAnswer(){  //store answer with a time stamp as new row in table
  //checks for the presence of 10 or ten
 // println("answer is "+answer);
  String check = "";
  String ts = month()+"/"+day()+"/"+year()+" "+hour()+":"+minute()+":"+second();
   // I call this a time stamp
TableRow newRow = results.addRow();  //add new row, with 2 or 3 values set
    newRow.setString("Time Stamp",ts);
 
    newRow.setString("Answer",answer);
  if (match(answer,correctanswers) !=null) {  //there was a match
     newRow.setString("Correct","Yes");
        check = " Correct! ";
    }
saveTable(results,"data/results.csv");
  background(0);  //clear screen
  text(check+"Click on screen to play again",200,200);
}

void mouseClicked() {  //re-starts the game by setting startTime as the current time and re-starting looping
   myText="";
   answer="";
   startTime = millis();
   loop();
}