import processing.opengl.*;

import JMyron.*;

PImage[] SET;

int rat = 50;
int numX,numY;
int sX,sY;
int mx,mn = 500;
int img[];


int which = 0,whichToDraw = 0;

JMyron m;

void setup(){
  size(720/2,576/2,OPENGL);
  m = new JMyron();//obj
  m.start(width,height);//45,36);//320x240
  m.findGlobs(0);

  frameRate(30);

  SET = new PImage[1];
  SET[0] = createImage(width,height,RGB);
  
  /*
  for(int i = 0;i<SET.length;i++){
   SET[i] = createImage(width,height,RGB); 
   
   }*/



  img = new int[numX*numY];

  //frame.setLocation(screen.width/2-width/2,screen.height/2-height/2); //works
  background(0);
  println("running!");
}
/*
public void init(){
 frame.setUndecorated(true);
 super.init(); 
 }*/

void draw(){
  display();
}

void display(){
  if(whichToDraw>SET.length-1){
    whichToDraw=0;
  }
  
  if(SET.length>1){
  background(SET[whichToDraw]);
  }else{
    background(SET[0]);
  }
  whichToDraw++;


}

void keyPressed(){
  if(keyCode==ENTER){
    add(); 
  }
  else if(keyCode==BACKSPACE){
    back(); 
  }
  else if(key == ' '){
    erase(); 
  }


}

void add(){
  m.update();
  img = m.image();
  which = SET.length;
  SET=(PImage[])expand(SET,SET.length+1);
  SET[which] = createImage(width,height,RGB);

  for(int x = 0; x<width;x++){
    for(int y = 0; y<height;y++){
      SET[which].pixels[y*width+x] = img[y*width+x];
    }    
  }
  SET[which].updatePixels(); 
}

void back(){
  if(SET.length>1){
  SET=(PImage[])subset(SET,0,SET.length-1);  
  which=0;
  }
}

void erase(){
   which=0;
  SET = new PImage[1];
  SET[0] = createImage(width,height,RGB);
}
