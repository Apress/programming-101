//collection of wedges drawn using beginShape and endShape representing a rainbox path.
//helix constructing using 2 helices, each with its own radius, inner irad and outer orad
//one layer of flat shapes drawn in 3D

Wedge[] strip = {};
int multiples = 9;  //multiples of rainbox segments
color[] rainbowColors = {
   color(148,0,211),
   color(75,0,130),
   color(0,0,255),
   color(0,255,0),
   color(255,255,0),
   color(255,127,0),
   color(255,0,0)
   };    
   
float rotx = 2.85;  //used to support mouse dragging changing orientation
float roty = 0.55;

float a = 300; //radius of helix
float b = -10; // step up for 1 turn
float WedgeWidth = a*PI/(3*7);  //3 complete rainbows per half a turn

float tDelta = PI/21;  //created to fit in 3 complete rainbows per half turn of helix
float irad = a;
float orad = a+WedgeWidth; 

void setup() {
  size(1000,800,P3D);

  float t = 0;  //used for parameterized curves representing the two helix coordinates.
  
  for(int i = 0;i<multiples;i++){
    for(int j=0;j<rainbowColors.length;j++) {
      
      float t1 = t;
      float t2 = t1+tDelta;
      strip = (Wedge[])append(strip,new Wedge(t1,t2, rainbowColors[j]));
      t = t2;  //each interation of inner loop advances the t1 and t2 values
      
    }
  }
 
}
void draw() {
  background(0);
  translate(width/2,height/2,0);
  rotateX(rotx);
  rotateY(roty);
  for(int i=0;i<strip.length;i++) {
    strip[i].display();
  
  }
}

class Wedge {  //compute and store the 4 vertex points for the wedge in the constructor
  float t1;  //do not use t1 or t2 after constructor 
  float t2;
  float h1x,h1y,h1z;
  float h2x,h2y,h2z;
  float h3x,h3y,h3z;
  float h4x,h4y,h4z;
 
  
  color colorR;
  Wedge(float t1a, float t2a, color c) {
    t1 = t1a;
    t2 = t2a;
  
    h1x = irad*cos(t1);
    h1y = b*t1;
    h1z = irad*sin(t1);
    
     h2x = irad*cos(t2);
     h2y = b*t2;
     h2z = irad*sin(t2);
     
     h3x = orad*cos(t2);
     h3y = b*t2;
     h3z = orad*sin(t2);
     
     h4x = orad*cos(t1);
     h4y = b*t1;
     h4z = orad*sin(t1);
     
    colorR = c;
   
  }
  void display() {
     fill(colorR);
     beginShape();
      vertex(h1x,h1y,h1z);
      vertex(h2x,h2y,h2z);
      vertex(h3x,h3y,h3z);
      vertex(h4x,h4y,h4z);
     endShape();    
  }
}

void mouseDragged() {
   float rate = 0.01;
   rotx += (pmouseY-mouseY)* rate;
   roty += (mouseX-pmouseX)* rate;
  
}

void mouseReleased() {
  float rate = 0.01;
   rotx += (pmouseY-mouseY)* rate;
   roty += (mouseX-pmouseX)* rate;
  
}