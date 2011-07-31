import processing.opengl.*;

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
int num = 500;
Org[] org = new Org[num];
PImage shade;
Recorder r;
boolean record =true;
//////////////////////////////////////////////////////////////////////

void setup(){
  size(1024,600,P3D);
  background(0);
//  textFont(loadFont("ZapfHumanist601BTCE-Ultra-18.vlw"));
 
  noStroke();
  fill(255);

  //frame.setLocation(0,0);
	//frame.setUndecorated(true);
  frame.setTitle("gene_tics by KOF");
  r = new Recorder("output","genetics1.avi");
  //shade = loadImage("shade.png");

  for(int i = 0;i<num;i++){
    
    org[i] = new Org(i);
  }
  background(0);
}

//////////////////////////////////////////////////////////////////////
/*
void init(){
  frame.setUndecorated(true);
  super.init(); 

}*/

void draw(){
  //background(0);
  noStroke();
  fill(0,100);
  rect(0,0,width,height);
  
  for(int i = 0;i<num;i++){
    if(i%50==0){
      filter(BLUR,1.3);
      noStroke();
    fill(0,15);
    rect(0,0,width,height);
    }
    org[i].run();
  }
  r.add();
}

//////////////////////////////////////////////////////////////////////

void mousePressed(){
  if(mouseButton==LEFT){
    for(int i = 0;i<num;i++){
      if(dist(org[i].x,org[i].y,mouseX,mouseY)<50){
        org[i].grow();
        org[i].mutate();
      }
    }
  }
  else{
    for(int i = 0;i<num;i++){
      org[i] = new Org(i);
    }

  }

}

//////////////////////////////////////////////////////////////////////

void keyPressed(){
 if (key=='q'){
  r.finish();
  exit();
  
 } 
  
  
}

//////////////////////////////////////////////////////////////////////


