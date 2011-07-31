import processing.video.*;

/*  little experiment ala Vasulka's ocillators from 70's
 *  get better results by lowering your brightness - simply press "s" key
 *  ..its all about calibration
 *  based on JMyron lib, thx!
 *  enjoy! Kof
 */

//------------->libs
import processing.opengl.*;


String ver = ("0.1");
Capture m;
int W = 720/2,H = 576/2;
PFont font;
int recv;
int[] img = new int[W*H];

int count,accept = 1,cn = 0;
float cnt = 0.0;
float avg;
float[] aa = new float[1001];
float[] ca = new float[1001];
int hold = 10;
float yLim = 40.0;
float[] Y = new float[W*H];
float[] speedY = new float[W*H];
 float r,g,b;
 MovieMaker mm;
void setup() {

  size(W,H,OPENGL);
  background(0);
  frameRate(15);        

  println(Capture.list()[0]);
  m = new Capture(this, W, H,Capture.list()[0]);
  mm = new MovieMaker(this, width, height, "random3.mov",15, MovieMaker.JPEG, MovieMaker.BEST);
  //smooth();
  font = loadFont("04b21-8.vlw"); //Uni0553-8.vlw
  textFont(font, 8);

}


void stop(){
  mm.finish();
  super.stop();

}


void draw() {
  falloff(35);
  vidko();
   mm.addFrame();
}

void falloff(int e) {
  fill(0,e);
  rect(0,0,width,height);
}

void vidko() {
  if (m.available()) {
    m.read();
    m.loadPixels();
    img = m.pixels;
   }
  
  for(int y=0;y<H;y+=1){ 

    beginShape();
    for(int x=0;x<W;x+=2){ 
      int id = y*W+x;
      float av = (red(img[id])+green(img[id])+blue(img[id]))/3.0;

     /* r= red(img[id]);
      g= green(img[id]);
      b= blue(img[id]);*/
      stroke(255,255-((Y[id]+5)*10),255-((Y[id]+5)*9),25/*80-((Y[id]+19)*3)*/);
      noFill();
      yLim=av/5.5;
      speedY[id] = -(av)/90.0;

      speedY[id] += avg/190.0;
      if(Y[id]>(yLim)){
        Y[id]=yLim;
      }
      else if(Y[id]<-yLim){
        Y[id]=(-yLim);
      }
      Y[id] += speedY[id];
      //strokeWeight(2);
      vertex(map(x,0,W,0,width),map((y+(Y[id])),0,H,0,height));
    }
    endShape();
  }
  avg= 100;
  
  //hlavicka();

}
void hlavicka() {
  fill(45);
  noStroke();
  rect(0, height-14, width, height);
  fill(255);
  text("xOSCILLER"+"::"+ver, width-80, height-4);
  text("KRYSTOF PESEK", 5, height-4);
  text("FPS x "+floor(frameRate),120,height-4);
  if(accept == 0){
    text("r MOVIE FINISHED" , 3, 10);
  }
}

void keyPressed() {
  if (key == 's'){
    m.settings();
  }
}


