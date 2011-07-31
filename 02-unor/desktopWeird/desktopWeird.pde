import processing.opengl.*;
PImage back;
PImage ff;
float x,y,tx,ty;

void setup(){
 // frame.setLocation(0,0);
  size(screen.width,screen.height,OPENGL);
  ff = loadImage("ff.png");
  back = loadImage("back.png");
  
  background(back);
  x=y=tx=ty=0;
}

void draw(){
  //background(back); 
 
  tx+=(mouseX-tx)/3.0;
  ty+=(mouseY-ty)/3.0;
  x+=(tx-x)/10.0;
  y+=(ty-y)/10.0;
  image(ff,10,10);
  
}

/*
public void init(){
  
  super.init(); 
}*/
