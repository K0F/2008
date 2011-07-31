import processing.opengl.*;
import JMyron.*;

String ver = ("0.1");

JMyron m;
PFont font;
int recv;
int W=720/2,H=576/2;

int count,accept = 1,cn = 0;
float cnt = 0.0f;
float avg;
float[] aa = new float[1001];
float[] ca = new float[1001];
int hold = 30;
float yLim = 40.0f;
float[] Y = new float[W*H];
float[] speedY = new float[W*H];
float rotace = 0;
void setup() {

  size(800,600,OPENGL);
  background(0);
  frameRate(25);
  setFullScreen( false );               
  setResolution( width, height );           
  createFullScreenKeyBindings();       
  smooth();
  //---------------------> video
  m = new JMyron();//obj
  m.start(W,H);//WxH
  m.findGlobs(0);
  //smooth();
  font = loadFont("04b21-8.vlw"); //Uni0553-8.vlw
  textFont(font, 8);
  frame.setLocation(screen.width,0);
  
  camera(0,0,-width*3,0,0,0,0,1,0);
}

void init(){
 frame.setUndecorated(true);
super.init(); 
  
}

void draw() {
  rotace+=0.01;
  //falloff(35);
  background(0);
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
  pushMatrix();
  translate(80,0);
  pushMatrix();
  rotateY(rotace);
  for(int y=0;y<m.height();y+=2){ 
    beginShape();
    for(int x=0;x<m.width();x+=2){ 
      int id = y*m.width()+x;
      float av = (red(img[id])+green(img[id])+blue(img[id]))/3.0;

      r= red(img[id]);
      g= green(img[id]);
      b= blue(img[id]);
      stroke(255,255-((Y[id]+5)*10),255-((Y[id]+5)*9),155); //100-((Y[id]+19)*3)
      noFill();
      yLim=av/5.5;
      speedY[id] = -(av)/90.0f;

      speedY[id] += avg/90.0f;
      if(Y[id]>(yLim)){
        Y[id]=yLim;
      }
      else if(Y[id]<-yLim){
        Y[id]=(-yLim);
      }
      Y[id] += speedY[id];
      strokeWeight(1);
      vertex(map(x,0,m.width(),-width,width),map(y,0,m.height(),-height,height),(Y[id])*5);
    }
    endShape();
  }
  popMatrix();
  popMatrix();
  avg= red(((m.average(0,0,width,height))));
  

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
