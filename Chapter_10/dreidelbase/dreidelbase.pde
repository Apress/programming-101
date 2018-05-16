// dreidel base

void setup() {
    size (600,600,P3D);
    translate(width/2, height/2,0);
    noStroke();
    scale(100);
  fill(100,100,0);
  //bottom triangle from each of the 4 sides to center point
  beginShape();
    vertex(-1,1,1);
    vertex(-1,1,-1);
    vertex(0,2,0);
    vertex(-1,1,1);
  endShape(CLOSE);
  fill(100,0,0);
  beginShape();
    vertex(1,1,1);
    vertex(1,1,-1);
    vertex(0,2,0);
    vertex(1,1,1);
  endShape(CLOSE);
  
  fill(0,100,0);
  beginShape();
    vertex(-1,1,-1);
    vertex(1,1,-1);
    vertex(0,2,0);
    vertex(-1,1,-1);
  endShape(CLOSE);
  
  fill(0,0,100);
  beginShape();
    vertex(-1,1,1);
    vertex(1,1,1);
    vertex(0,2,0);
    vertex(-1,1,1);
  endShape(CLOSE);
  
} 