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
  size(320,240,OPENGL);
  m = new JMyron();//obj
  m.start(width,height);//45,36);//320x240
  m.findGlobs(0);

  frameRate(30);

  SET = new PImage[1];
  SET[0] = createImage(width,height,ARGB);
  
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
  //// looping ///////////////// >
  if(whichToDraw>SET.length-1){
    whichToDraw=0;
  }
  //// shifting ///////////////// >
  if(SET.length-1>0){
     whichToDraw++; 
  }
  //// drawing ///////////////// >
  if(whichToDraw<SET.length){
    tint(255,155);
   image(SET[whichToDraw],0,0);
  }


}

void keyPressed(){
  if(keyCode==ENTER){
    add(); 
  }
  else if((keyCode==BACKSPACE)||(key == '.')){
    back(); 
  }
  else if((key == ' ')||(key == '0')){
    erase(); 
  }else if(key == '1'){
   newLoop(1); 
  }else if(key == '2'){
   newLoop(2); 
  }else if(key == '3'){
   newLoop(3); 
  }else if(key == '4'){
   newLoop(4); 
  }else if(key == '5'){
   newLoop(5); 
  }else if(key == '6'){
   newLoop(6); 
  }else if(key == '7'){
   newLoop(7); 
  }else if(key == '8'){
   newLoop(8); 
  }else if(key == '9'){
   newLoop(9); 
  }


}

void add(){
  m.update();
  img = m.image();
  which = SET.length;
  SET=(PImage[])expand(SET,SET.length+1);
  SET[which] = createImage(width,height,ARGB);

  for(int x = 0; x<width;x++){
    for(int y = 0; y<height;y++){
      
      SET[which].pixels[y*width+x] = (img[y*width+x]);
      
    }    
  }
  //SET[which].updatePixels(); 
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
  add();
  //SET[0] = createImage(width,height,RGB);
}

void newLoop(int kolik){
  which=0;
  SET = new PImage[1];
 for(int i = 0;i<kolik;i++){
  add();
 } 
  
}
