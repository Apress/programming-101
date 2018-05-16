//bouncing balls

float[] bxs = {450,225, 675};
float[] bys = {450, 300, 150};
float[] dxs = { 3,2,1};
float[] dys  = {3,1,2};
int[] balldiams = {20,40,60};

void setup() {
  size(900,600);
}

void draw(){
  background(0);  
  for (int i=0;i<bxs.length;i++) 
  {
   ellipse(bxs[i],bys[i],balldiams[i], balldiams[i]);
   bxs[i] = bxs[i]+dxs[i];
   if ((bxs[i]>=width)||(bxs[i]<=0)) {dxs[i] = -dxs[i];}
   bys[i] = bys[i] + dys[i];
   if ((bys[i]>=height)||(bys[i]<=0)) {dys[i] = -dys[i];}
  }   
}