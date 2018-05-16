//acquire image online at specific url.

PImage original;
Boolean nowOrig = true;
float rfactor = 0.2980;
float gfactor = 0.5870;
float bfactor = 0.1140;

String url = "http://faculty.purchase.edu/jeanine.meyer/esther.jpg";
int imgw;
int imgh;

void setup() {
  size(800,800);
  textSize(20);
  fill(0);
  original = loadImage(url);
  if (original !=null) {
    imgw = 2*original.width;
    imgh = 2*original.height;
    image(original, 0,0,imgw,imgh);
     text("Press any key to toggle between original and grayscale",20,imgh+50);
  }
  else {
    text("Bad address for image. Change url variable.",20,100);
  }
}

void draw() {  }

void keyPressed() {
  if (nowOrig) {
    loadPixels();
    for(int i=0;i<pixels.length;i++) {
     float redc = red(pixels[i]);
     float greenc = green(pixels[i]);
     float bluec = blue(pixels[i]);
   //  float gs =  redc*.3+greenc*.59+bluec*.11;
     float gs = redc*rfactor+greenc*gfactor+bluec*bfactor;
     color gscolor = color(gs,gs,gs);
     pixels[i] = gscolor;
    }
    updatePixels();
    nowOrig = false;
  }
  else {
    image(original,0,0,imgw,imgh);
    nowOrig = true;
  }
}