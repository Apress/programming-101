//solar system, based on (inspired by) Lauren Collishaw's final project though I did omit Pluto.
//planaets rotate in a circular orbit around the sun. (These orbits actually are elliptical, though very close to a circle.)
//The sizes and the distances are not proportional.

//Note the use of pushMatrix and popMatrix. This prevents cumulative effects of transformations.

int mercury = 0;
int venus = 1;
int earth=2;
int mars=3;
int jupiter=4;
int saturn=5;
int uranus=6;
int neptune=7;
int pluto=8;
Planet[] planets = new Planet[9];
//orbits are not circles, but do circles for now
int ctrx = 600;
int ctry = 500;
int ctrz = -200;
float time = 0;
//float ptilt = -PI * 17/180;  //tilt of plane of Pluto, actual tilt is 17 degrees
float ptilt = -PI/6;  //pretend tilt of 30 degrees



void setup() {
  size(2500,1000,P3D);
  planets[mercury] = new Planet(color(63,67,250),30,350,.2);
  planets[venus] =   new Planet(color(133,14,170),75,670,0.15);
  planets[earth] = new Planet(color(69,140,229),79,920,.12);  //squeeze
  planets[mars] =   new Planet(color(255,0,0),42,1000,0.1);   //red planet
   planets[jupiter] = new Planet(color(237,175,41),89,1300,.08);
  planets[saturn] =   new Planet(color(115,41,237),75,1600,0.06);
   planets[uranus] = new Planet(color(225,232,54),32,1800,.05);
  planets[neptune] =   new Planet(color(54,186,255),25,1999,0.05);

  planets[pluto] = new ObPlanet(color(0,200,250),20, 2059,.035,ptilt);  //tilted orbit
  frameRate(20);
}
void draw() {
  background(0);
  //directionalLight(800,-500,-500,1,1,1);  //Lauren had two lights. This might be a good effect
  directionalLight(900, 500, 500,-1, -1, -1);
  //sun
  fill(245,198,25);
  pushMatrix();
  translate(ctrx,ctry,ctrz);
  sphere(180);
  popMatrix();
  // planets
  for(int i=0;i<planets.length;i++)
    {
      planets[i].moveAndShow();
    }
    time = time+.3;

}
class Planet
{
  color pcolor;
  int psize;
 
  float radius;
  float speed;
  Planet (color pcol, int psizea, float pradius, float pspeed) {  //sets all the relevant data for each planet
    pcolor = pcol;
    psize = psizea;  //size of planet
   
    radius = pradius;  //radius of orbit
    speed = pspeed;    //speed of orbit
    
    
  }
  void moveAndShow() {  //adjust position using center which is also the fixed position of sun
    float x,y,z;
    pushMatrix();
    x = ctrx + radius*sin(speed*time);
    y = ctry;
    z = ctrz + radius*cos(speed*time);
    noStroke();
    fill(pcolor);
    translate(x,y,z);
    sphere(psize);
    popMatrix();
  }
  
}
class ObPlanet extends Planet {
   float tilt;
   ObPlanet (color pcol, int psizea, float pradius, float pspeed, float itilt){
      super (pcol, psizea, pradius, pspeed);
      tilt = itilt;
   }
   void moveAndShow() {  //adjust position using center which is also the fixed position of sun
    float x,y,z;
    pushMatrix();
    translate(ctrx,ctry,ctrz);
    rotateX(tilt);
   
    x = radius*sin(speed*time);
    y = 0;
    z = radius*cos(speed*time);
    noStroke();
    fill(pcolor);
    translate(x,y,z);
    sphere(psize);
    popMatrix();
  }
}