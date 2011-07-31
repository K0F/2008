/*  little experiment ala Vasulka's ocillators from 70's
 *  get better results by lowering your brightness - simply press "s" key
 *  ..its all about calibration
 *  based on JMyron lib, thx!
 *  enjoy! Kof
 */

//------------->libs
import processing.opengl.*;
import JMyron.*;

String ver = ("0.1");

JMyron m;
PFont font;
int recv;
int W=450,H=288;

int count,accept = 1,cn = 0;
float cnt = 0.0;
float avg;
float[] aa = new float[1001];
float[] ca = new float[1001];
int hold = 30;
float yLim = 40.0;
float[] Y = new float[W*H];
float[] speedY = new float[W*H];

void setup() {

  size(1024,768,OPENGL);
  background(0);
  frameRate(25);
  setFullScreen( false );               
  setResolution( width, height );           
  createFullScreenKeyBindings();       

  //---------------------> video
  m = new JMyron();//obj
  m.start(W,H);//WxH
  m.findGlobs(0);
  //smooth();
  font = loadFont("04b21-8.vlw"); //Uni0553-8.vlw
  textFont(font, 8);

}


void draw() {
  falloff(35);
  vidko();
}

void falloff(int e) {
  fill(0,e);
  rect(0,0,width,height);
}

void vidko() {
  m.update();
  int[] img = m.image();
  float r,g,b;

  for(int y=0;y<m.height();y+=1){ 
    beginShape();
    for(int x=0;x<m.width();x+=2){ 
      int id = y*m.width()+x;
      float av = (red(img[id])+green(img[id])+blue(img[id]))/3.0;

      r= red(img[id]);
      g= green(img[id]);
      b= blue(img[id]);
      stroke(255,255-((Y[id]+5)*10),255-((Y[id]+5)*9),10); //100-((Y[id]+19)*3)
      noFill();
      yLim=av/5.5;
      speedY[id] = -(av)/90.0;

      speedY[id] += avg/90.0;
      if(Y[id]>(yLim)){
        Y[id]=yLim;
      }
      else if(Y[id]<-yLim){
        Y[id]=(-yLim);
      }
      Y[id] += speedY[id];
      strokeWeight(2);
      vertex(x*3,(y+(Y[id]))*3);
    }
    endShape();
  }
  avg= red(((m.average(0,0,width,height))));
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

public void stop() {
  m.stop();
  super.stop();
}
