// snowman

float firstRadius = 100;
float secondRadius = firstRadius*2/3;
float thirdRadius = secondRadius*2/3;

void setup() {
  size(800,800,P3D);
  stroke(200);
  fill(255);
  
}

void draw() {
   pushMatrix();
    translate(width/2, height/2,0);
   sphere(firstRadius);
   translate(0,-firstRadius,0);
   sphere(secondRadius);
   translate(0,-secondRadius,0);
   sphere(thirdRadius);
  popMatrix();
  pushMatrix();
   translate(width/2, height/2,0);
   translate(0,firstRadius*.75,0);
   fill(0,100,0);
   box(500,50,500);
   fill(255);
   popMatrix();
  
}