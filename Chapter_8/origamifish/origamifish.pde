//origami talking fish. Converted from version made in HTML5 JavaScript.
//Note the use of a Library. This requires installing the Library using the Processing/Sketch/Install Library...
// and also including the iimport command in the code.
//Demonstrates using different features when needed: for example, videos for certain steps and photos for certain steps
//while using the official origami style line drawings for most of the steps.


import processing.video.*;

Movie sinkVideo;
Movie talkVideo;
boolean sinkPlaying = false;
boolean talkPlaying = false;
PImage cleft;
PImage throat1;
PImage throat2;
PFont myfont;
String direction1 = "Press buttons to advance or go back";
Button[] buttons;
color backgroundcolor = color(255);
int textx = 250;
int texty = 460;

void setup() {
  size(900,600);
  myfont = createFont("Georgia",16);
  textFont(myfont);
  cleft = loadImage("cleftlip.jpg");
  throat1 = loadImage("throat1.jpg");
  throat2 = loadImage("throat2.jpg");
  sinkVideo = new Movie(this, "sink.mp4");
  talkVideo = new Movie(this, "talk.mp4");
  fill(0);
 
  text(direction1,textx,texty);
  makeButtons();
  showButtons();
  nextstep = 0;
  
}

void draw() {
   if (sinkPlaying) {
     image(sinkVideo,0,0);
   }
   else if (talkPlaying) {
      image(talkVideo,0,0);
   }
}

void makeButtons() {  //all buttons are the same size. 
  buttons = new Button[2];
  buttons[0] = new Button("GO BACK",250,520,color(200,0,0));
  buttons[1] = new Button("NEXT STEP",400,520,color(0,200,100));
}
void showButtons() {
  for (int i = 0;i<buttons.length;i++) {
    buttons[i].display();
  }
}
void mouseClicked() { //only 2 Button objects.
 
  if (buttons[0].isOver(mouseX, mouseY)) {
     // println("about to go back, nextstep is ",nextstep);
      goback();
  }
  else if (buttons[1].isOver(mouseX,mouseY)) {
   // println("about to donext, nextstep is ",nextstep);
    donext();
  } 
}

float dotradius = 4;
float ctx;
float cwidth;
float cheight;
String ta;
float kamiw = 4;
float kamih = 4;
int i2p = 72;
int dashlen = 8;
float dgap = 4.0;
float ddashlen = 6.0;
float ddot = 2.0;
float dratio = dashlen/(dashlen+dgap);
float ddtotal = ddashlen+3*ddot;
float ddratio1 = ddashlen/ddtotal;
float ddratio2 = (ddashlen+ddot)/ddtotal;
float ddratio3 = (ddashlen+2*ddot)/ddtotal;

float kamix = 10;
float kamiy = 10;
int nextstep;

float[] intersect(float x1,float y1,float x2,float y2,float x3,float y3,float x4,float y4) {
  //only works on line segments that do intersect and are not 
  //vertical
  float[] ans = new float[2];
  float m12 = (y2-y1)/(x2-x1);
  float m34 = (y4-y3)/(x4-x3);
  float m = m34/m12;
  ans[0]= (x1-y1/m12-m*x3+y3/m12)/(1-m);
  ans[1] = m12*(ans[0]-x1)+y1;
  return ans;
}

void directions() {
  fill(0);
  textAlign(LEFT);
  
 text("Make valley fold", 20,20);
 stroke(0,200,0);
  valley(200,18,300,18);
 text("Make mountain fold",20,50);
  mountain(200,48,300,48);
  stroke(0);
  text("unfolded fold line",20,100);
  skinnyline(200,98,300,98);
  text("When sense of fold matters:",20,150);
  text("unfolded valley fold", 20,180);
  valley(200,178,300,178);
  text("unfolded mountain fold",20,210);
  mountain(200,208,300,208);
 
}



void donext() {
  if (nextstep>=steplabels.length) {
    nextstep=steplabels.length-1;
  }
  //this may be overkill. Stopping videos each time.
  talkPlaying = false;
  sinkPlaying = false;
  talkVideo.stop();
  sinkVideo.stop();
  
  background(255); 
 
  switch (nextstep){  //this corresponds to the order of labels in the steplabels array
    case 0: 
     directions();
     break;
    case 1:
     showkami();
     break;
    case 2: 
     diamond1();
     break;
    case 3:
     triangleM();
     break; 
     case 4: 
     thirds();
     break;
    case 5:
     rttriangle();
     break;
    case 6: 
     cornerdown();
     break;
    case 7:
    unfolded();
     break; 
     case 8: 
    changedfolds();
     break;
    case 9:
     precollapse();
     break;
    case 10: 
     playsink();
     break;
    case 11:
     littleguy();
     break; 
     case 12: 
     oneflapup();
     break;
    case 13:
     bothflapsup();
     break;
    case 14: 
    finsp();
     break;
    case 15:
     preparelips();
     break; 
     case 16: 
     showcleftlip();
     break;
    case 17:
     lips();
     break;
    case 18: 
     showthroat1();
     break;
    case 19:
     showthroat2();
     break; 
     case 20: 
      rotatefish();
     break;
    case 21:
     playtalk();
     break;
  
  }
  fill(0);  //set text to black
  ta = steplabels[nextstep];
  textAlign(LEFT);
  text(ta,textx,texty);
  showButtons();
  nextstep++;
  fill(255);  //set back to white
  stroke(0); //set back to black
}
void goback() {
  nextstep = nextstep -2;
  if (nextstep<0) {
       nextstep = 0;
  }
  donext();
}

void shortdownarrow(float x,float y) {
  beginShape();
  vertex(x,y-20);
  vertex(x,y-7);
  vertex(x-5,y-12);
  vertex(x,y-7);
  vertex(x+5,y-12);
  vertex(x,y-7);
  endShape();
  
  
}
float[] proportion(float x1,float y1,float x2,float y2,float p) {
  float[] ans = new float[2];
  float xs = x2-x1;
  float ys = y2-y1;
  ans[0] = x1+ p*xs;
  ans[1] = y1 + p* ys;
  return ans;
}

void showcleftlip() {
 drawImage(cleft,40,40);
}

void skinnyline(float x1,float y1,float x2,float y2) {
  strokeWeight(1);
  line(x1,y1,x2,y2);
}



void curvedarrow(float x1,float y1,float x2,float y2, float px,float py) {
 //  
  float arrowanglestart;
  float arrowanglefinish; 
  float d = dist(x1,y1,x2,y2);
  float rad=sqrt(4.25*d*d);
  
  float ctrx;
  float ctry;
  float ex;
  float ey;
  float angdel = atan2(d/2,2*d);
  //angdel is .24497 in this sketch, but leave it general
  float fromhorizontal;
  stroke(255,0,0);
  beginShape();
  if (y1==y2) {
      arrowanglestart = 1.5*PI-angdel;
      arrowanglefinish = 1.5*PI+angdel;
       ctrx = .5*(x1+x2) +px;
       ctry = y1+2*d +py;
       if (x1<x2) {
         
       //done to get arrow head at correct position. In this clas right
       noFill();
       
      arc(ctrx,ctry,2*rad,2*rad,arrowanglestart,arrowanglefinish);
       fromhorizontal=2*PI- arrowanglefinish;
       ex = ctrx+rad*cos(fromhorizontal);
       ey = ctry - rad*sin(fromhorizontal);
       vertex(ex-8,ey+8);
       vertex(ex,ey);
       vertex(ex-8,ey-8);
       }
       else {
       // arrow
       noFill();
       stroke(200,0,0);
    //arrow head at the left
     arc(ctrx,ctry,2*rad,2*rad,arrowanglestart,arrowanglefinish);
         fromhorizontal=2*PI- arrowanglestart;
       ex = ctrx+rad*cos(fromhorizontal);
       ey = ctry - rad*sin(fromhorizontal);
       vertex(ex+8,ey+8);
       vertex(ex,ey);
       vertex(ex+8,ey-8);
       }
     endShape();
      
    }
  else if (x1==x2) {
    arrowanglestart = -angdel;
      arrowanglefinish = angdel;
        ctrx = x1-2*d+px;
       ctry = .5*(y1+y2) + py;
       if (y1<y2) {
     
      noFill();
       arc(ctrx,ctry,2*rad,2*rad,arrowanglestart,arrowanglefinish);
       fromhorizontal=- arrowanglefinish;
       ex = ctrx+rad*cos(fromhorizontal);
       ey = ctry - rad*sin(fromhorizontal);
       vertex(ex-8,ey-8);  //arrow head at top
       vertex(ex,ey);
       vertex(ex+8,ey-8);
       }
       else {
    
     noFill();
     arc(ctrx,ctry,2*rad,2*rad,arrowanglefinish,arrowanglestart);
         fromhorizontal=- arrowanglestart;
       ex = ctrx+rad*cos(fromhorizontal);
       ey = ctry - rad*sin(fromhorizontal);
       //arrow head at bottom
       vertex(ex-8,ey+8);
       vertex(ex,ey);
       vertex(ex+8,ey+8);
       }
       endShape();
      }
      stroke(0);
}

//specific to fish
String[] steplabels= {  //must correspond with the switch statement.
 "Diagram conventions. Kissy fish by Junior Fritz Jacquet from Piranha by Jun Maekawa.",
     "Make quarter turn.",
  "Fold top point to bottom point.",
  "Divide line into thirds and make valley folds and unfold ",
  "Fold in half to the left.",
  "Fold down the right corner to the fold marking a third. ",
  "Unfold everything.",
  "Prepare to sink middle square by reversing folds as indicated ...",
  "Note middle square sides all valley folds, some other folds changed. Flip over.",
  "Push sides to sink middle square.",
  "Sink square, collapse model.",
  "Now fold back the right flap to center valley fold. You are bisecting the indicated angle.",
  "Do the same thing to the flap on the left",
  "Make fins by wrapping top of right flap around 1 layer and left around back layer",
  "Now make lips...make preparation folds",
  "and turn lips inside out. Turn corners in...",
  "...making cleft lips.",
  "Pick up fish and look down throat...",
  "Stick your finger in its mouth and move the inner folded material to one side",
  "Throat fixed.",
  "Squeeze & release top and bottom to make fish's mouth close and open",
  "Talking fish."
};


float diag = kamiw* sqrt(2.0)*i2p;
float ax = 10;
float ay = 220;
float bx = ax+ .5*diag;
float by = ay - .5*diag;
float cx = ax + diag;
float cy = ay;
float dx = bx;
float dy = ay + .5*diag;
float[] e = proportion(ax,ay,cx,cy,.333333);
float ex = e[0];
float ey = e[1];
float[] f = proportion(ax,ay,cx,cy,.666666);
float fx = f[0];
float fy = f[1];
float[] g = proportion(ax,ay,dx,dy,.666666);
float gx = g[0];
float gy = g[1];
float[] h = proportion(cx,cy,dx,dy,.666666);
float hx = h[0];
float hy = h[1];
float jx = ax + .5*diag;
float jy = ay;
float diag6 = diag/6;
float gry = ay-(gy-ay);
float kx = ax+diag/3;
float ky = ay;
float lx = kx + diag/3;
float ly = ay;
float mx = ax + diag/6;
float innersq = sqrt(2)*diag/6;
float my = ay + innersq*sin(PI/4);
float nx = ax+diag/3+diag/6;
float ny = my;
float px = mx;
float py = dy;
float rx = nx;
float ry = py;
float qx = kx;
float qy = hy;
float dkq = qy-ky;
float sx = kx + (dkq/cos(PI/8))*sin(PI/8);
float sy = ay;
float tx = kx;
float ty = qy-dist(qx,qy,lx,ly);
float[] xxa = intersect(sx,sy,qx,qy,kx,ky,nx,ny);
float xxx = xxa[0];
float xxy = xxa[1];
float xxlx = kx-(xxx-kx);
float xxly = xxy;
float slx = kx- (sx-kx);
float sly = sy;
float tlx = tx-5;
float tly = ty;
float dkt=ky-ty;
float finlx = kx-dkt;
float finly = ky;
float finrx = kx+dkt;
float finry = ky;
float w = cos(PI/4)*dkt;
float wx = kx-.5*dkt;
float wy = w*sin(PI/4)+ky;
float zx = kx+.5*dkt;
float zy = wy;
float plipx = px;
float plipy = py-10;
float rlipx = rx;
float rlipy = ry-10;
float plipex = px - 10;
float plipey = plipy;
float rlipex = rx + 10;
float rlipey = rlipy;
float[] rclipcleft1 = proportion(rlipex,rlipey,rlipx,rlipy,.5);
float[] pclipcleft1 = proportion(plipex,plipey,plipx,plipy,.5);
float[] rclipcleft2 = proportion(rlipex,rlipey,qx,qy,.1);
float[] pclipcleft2 = proportion(plipex,plipey,qx,qy,.1);
float rcx1 = rclipcleft1[0];
float rcy1 = rclipcleft1[1];
float rcx2 = rclipcleft2[0];
float rcy2 = rclipcleft2[1];
float pcx1 = pclipcleft1[0];
float pcy1 = pclipcleft1[1];
float pcx2 = pclipcleft2[0];
float pcy2 = pclipcleft2[1];
float v;

void drawImage(PImage img, float x, float y) {
   image (img, x, y);
  
}

void showthroat1() {
  drawImage(throat1,40,40);
}
void showthroat2() {
  drawImage(throat2,40,40);
}
void playsink() {
   sinkVideo.loop();
   sinkPlaying = true;
  //  canvas1.height = 126;  //adjusts for height of video
}

void playtalk() {
  talkVideo.loop();
  talkPlaying = true;
 // canvas1.height = 178;  //adjusts for height of video
}

void movieEvent(Movie m) {
  m.read();
}

void lips() {
  fill(0,128,128);  //teal
  beginShape();
  vertex(finlx,finly);
  vertex(kx,ky);
  vertex(wx,wy);
  vertex(finlx,finly);
  endShape();
  beginShape();
  vertex(finrx,finry);
  vertex(kx,ky);
  vertex(zx,zy);
  vertex(finrx,finry);
  endShape();
  beginShape();
  vertex(mx,my);
  vertex(kx,ky);
  vertex(xxx,xxy);
  vertex(qx,qy);
  vertex(plipx,plipy);
  vertex(mx,my);
  endShape();
  beginShape();
  vertex(xxx,xxy);
  vertex(nx,ny);
  vertex(rlipx,rlipy);
  vertex(qx,qy);
  vertex(xxx,xxy);  
  endShape();
  
  fill(255,255,255);
  beginShape();
  vertex(qx,qy);
  vertex(pcx2,pcy2);
  vertex(pcx1,pcy1);
  vertex(plipx,plipy);
  vertex(qx,qy);
  vertex(rcx2,rcy2);
  vertex(rcx1,rcy1);
  vertex(rlipx,rlipy);
  vertex(qx,qy);
  endShape();
  
  skinnyline(kx,ky,qx,qy);
  fill(0,128,128);  //teal
}
void rotatefish() {
  pushMatrix();
  translate(kx,my);
  rotate(-PI/2);
  translate(-kx,-my);
  lips();
  popMatrix();
}

void preparelips() {
  fill(0,128,128);
  fins();
  
  valley(qx,qy,rlipx,rlipy);
  valley(qx,qy,plipx,plipy);  
}
void finsp() {
  fill(0,128,128);
  fins();
  stroke(255,165,0);
  valley(qx,qy,rlipx,rlipy);
  valley(qx,qy,plipx,plipy); 
  stroke(0);
}

void fins() {
  beginShape();
  vertex(finlx,finly);
  vertex(kx,ky);
  vertex(wx,wy);
  vertex(finlx,finly);
  endShape();
  beginShape();
  vertex(finrx,finry);
  vertex(kx,ky);
  vertex(zx,zy);
  vertex(finrx,finry);
  endShape();
  beginShape();
  vertex(mx,my);
  vertex(kx,ky);
  vertex(xxx,xxy);
  vertex(qx,qy);
  vertex(px,py);
  vertex(mx,my);
  endShape();
  beginShape();
  vertex(xxx,xxy);
  vertex(nx,ny);
  vertex(rx,ry);
  vertex(qx,qy);
  vertex(xxx,xxy);  
  endShape();
  
  skinnyline(kx,ky,qx,qy);
  //ctx.fillText("finl", finlx,finly);
  //ctx.fillText("w",wx,wy);
  //ctx.fillText("zee",zx,zy);
}
void bothflapsup () {
  fill(0,128,128);  
  beginShape();
  vertex(slx,sly);
  vertex(tlx,tly);
  vertex(kx,ky);
  vertex(xxlx,xxly);
  vertex(slx,sly);
  endShape();
  beginShape();
  vertex(mx,my);
  vertex(kx,ky);
  vertex(sx,sy);
  vertex(qx,qy);
  vertex(px,py);
  vertex(mx,my);
  endShape();
  beginShape();
  vertex(tx,ty);
  vertex(sx,sy);
  vertex(kx,ky);
  vertex(tx,ty);
  endShape();
  beginShape();
  vertex(xxx,xxy);
  vertex(nx,ny);
  vertex(rx,ry);
  vertex(qx,qy);
  vertex(xxx,xxy);
  endShape();
  
  skinnyline(kx,ky,qx,qy);
 // text("sl",slx-20,sly);
 // text("tl",tlx,tly);
}
void oneflapup() {
   fill(0,128,128);
   beginShape();
   vertex(ax,ay);
   vertex(kx,ky);
   vertex(mx,my);
   vertex(ax,ay);
   endShape();
   beginShape();
   vertex(kx,ky);
   vertex(sx,sy);
   vertex(qx,qy);
   vertex(px,py);
   vertex(mx,my);
   vertex(kx,ky);
   endShape();
   beginShape();
   vertex(xxx,xxy);
   vertex(nx,ny);
   vertex(rx,ry);
   vertex(qx,qy);
   vertex(xxx,xxy);
   endShape();
   beginShape();
   vertex(kx,ky);
   vertex(tx,ty);
   vertex(sx,sy);
   vertex(kx,ky);
   endShape();
   
   skinnyline(qx,qy,kx,ky);
}
void littleguy() {
   fill(0,128,128);
   beginShape();
   vertex(ax,ay);
   vertex(kx,ky);
   vertex(mx,my);
   vertex(ax,ay);
   endShape();
   beginShape();
   vertex(kx,ky);
   vertex(lx,ly);
   vertex(px,py);
   vertex(mx,my);
   vertex(kx,ky);
   endShape();
   beginShape();
   vertex(nx,ny);
   vertex(rx,ry);
   vertex(qx,qy);
   vertex(nx,ny);
   endShape();
   
   skinnyline(qx,qy,kx,ky);
   beginShape();
  // ctx.arc(qx,qy,30,-.5*PI,-.25*PI,false);
   
   stroke(255,165,0);  //orange
   mountain(qx,qy,sx,sy);
   stroke(0);  //restore to black
}

void unfolded() {
  diamond();
  valley(ax,ay,cx,cy);
  valley(ex,ey,gx,gy);
  valley(fx,fy,hx,hy);
  mountain(ex,ey,gx,gry);
  mountain(fx,fy,hx,gry);
  valley(jx,jy,dx,dy);
  mountain(jx,jy,bx,by);
  valley(ex,ey,jx,jy+diag6);
  valley(jx,jy-diag6,fx,fy);
  mountain(ex,ey,jx,jy-diag6);
  mountain(jx,jy+diag6,fx,fy);  
}
void precollapse() {
  diamondc();
  mountain(ax,ay,cx,cy);
  valley(ex,ey,gx,gy);
  valley(fx,fy,hx,hy);
  valley(ex,ey,gx,gry);
  valley(fx,fy,hx,gry);
  valley(jx,jy-diag6,jx,jy+diag6);
  
  mountain(jx,jy-diag6,bx,by);
  mountain(jx,jy+diag6,dx,dy);
  mountain(ex,ey,jx,jy+diag6);
  mountain(jx,jy-diag6,fx,fy);
  mountain(ex,ey,jx,jy-diag6);
  mountain(jx,jy+diag6,fx,fy);  
}
void changedfolds() {
  diamond();
  valley(ax,ay,cx,cy);
  mountain(ex,ey,gx,gy);
  mountain(fx,fy,hx,hy);
  mountain(ex,ey,gx,gry);
  mountain(fx,fy,hx,gry);
  mountain(jx,jy-diag6,jx,jy+diag6);
  valley(jx,jy-diag6,bx,by);
  valley(jx,jy+diag6,dx,dy);
  valley(ex,ey,jx,jy+diag6);
  valley(jx,jy-diag6,fx,fy);
  valley(ex,ey,jx,jy-diag6);
  valley(jx,jy+diag6,fx,fy);  
}
void triangleM() {
  triangle();
  shortdownarrow(ex,ey);
  shortdownarrow(fx,fy);
  stroke(255,165,0);
  valley(ex,ey,gx,gy);
  valley(fx,fy,hx,hy);
  stroke(0);
}

void thirds() {
  triangle();
  skinnyline(ex,ey,gx,gy);
  skinnyline(fx,fy,hx,hy);
  curvedarrow(cx,cy,ax,ay,0,-20);
  stroke(255,165,0);  //orange
  valley(jx,jy,dx,dy);
  stroke(0);
}
void cornerdown() {
  rttriangle();
  clearRect(ex,ey-3, diag6+5,diag6);  //erase upper corner
  beginShape();
  vertex(ex,ey);
  vertex(ex+diag6,ey+diag6);
  vertex(ex,ey+diag6);
  vertex(ex,ey);
  endShape();
  
}


void showkami() {
  rect(kamix,kamiy,kamiw*i2p,kamih*i2p);
  }
  
void diamond1() {
  diamond();
  stroke(255,165,0);
  valley(ax,ay,cx,cy);
  curvedarrow(bx,by,dx,dy,10,0);
  stroke(0);
  
}
void diamondc() {
  fill(0,128,128);
  beginShape();
  vertex(ax,ay);
  vertex(bx,by);
  vertex(cx,cy);
  vertex(dx,dy);
  vertex(ax,ay);
  endShape();
  fill(0,128,128);
  
  
}

void diamond() {
  beginShape();
  vertex(ax,ay);
  vertex(bx,by);
  vertex(cx,cy);
  vertex(dx,dy);
  vertex(ax,ay);
  endShape();
  
}

void triangle() {
  fill(0,128,128);
  beginShape();
  vertex(ax,ay);
  vertex(cx,cy);
  vertex(dx,dy);
  vertex(ax,ay);
  endShape();
  
}
void rttriangle() {
  fill(0,128,128);
  beginShape();
  vertex(ax,ay);
  vertex(jx,jy);
  vertex(dx,dy);
  vertex(ax,ay);
  endShape();
  stroke(255,165,0);
  valley(ex,ey,ex+diag6,ey+diag6);
  skinnyline(ex,ey,gx,gy);
  stroke(0);
}

void valley(float x1,float y1,float x2,float y2) {
  float px=x2-x1;
  float py = y2-y1;
  float len = dist(x1,y1,x2,y2);
  float nd = int(len/(dashlen+dgap));
  float xs = px/nd;
  float ys = py/nd;
 
  for (int n=0;n<nd;n++) {   
   line(x1+n*xs, y1+n*ys,x1+n*xs+dratio*xs,y1+n*ys+dratio*ys);
  }
  
}
void mountain(float x1,float y1,float x2,float y2) {
  
  float px=x2-x1;
  float py = y2-y1;
  float len = dist(x1,y1,x2,y2);
  float nd = int(len/ddtotal);
  
  float xs = px/nd;
  float ys = py/nd;
 
 
  for (int n=0;n<nd;n++) {
   
    line(x1+n*xs,y1+n*ys,x1+n*xs+ddratio1*xs,y1+n*ys+ddratio1*ys);
  
    line(x1+n*xs+ddratio2*xs, y1+n*ys+ddratio2*ys,x1+n*xs+ddratio3*xs,y1+n*ys+ddratio3*ys);
    
  }
  
}
class Button {
  int cx;
  int cy;
  int bw,bh,bwsq,bhsq; //used for display and isOver calculation
  color labelColor;
  String label;
  Button(String labelA, int xposA, int yposA, color c) {
    cx = xposA;
    cy = yposA;
    labelColor = c;
    label = labelA;
    bw = 90;
    bh = 60;
    bwsq = 45*45;  //square half the width
    bhsq = 30*30;  //square half the height
  }
   boolean isOver(int x,int y)  //a way to determine if x, y is over the button that avoids taking square root
  {
    float disX = cx - x;
    float disXsq = disX * disX;
    float disY = cy - y;
    float disYsq = disY * disY;
    float v = (disXsq / bwsq) + (disYsq/bhsq);
    if (v<1) 
     {
       return true;
     }
    else 
     {
       return false;
     }
  }
  void display()
  {
     stroke(0);  //black outline
    fill(labelColor);
     ellipse(cx,cy,bw,bh);
     fill(0);
     textAlign(CENTER,CENTER);
     text (label,cx,cy);
  }
}

void clearRect (float x1, float y1, float w, float h) {
   fill(backgroundcolor);
   noStroke();
   
   rect(x1,y1,w,h);
  
   stroke(0);
   fill(255);
}