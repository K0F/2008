import java.io.File;
import processing.opengl.*;

PImage[] picts;
PImage crsr;

int cnt = 0;
int current = 0;
String[] fileNames;
boolean exposing = false;
int time;
float[] scaler;
float[] x;
float[] y;
boolean display = true;

void init(){
  frame.setUndecorated(true);
  super.init(); 

}

void setup(){
  size(screen.width,screen.height,OPENGL);
  frameRate(30);
  crsr = loadImage("cursor.png");
  cursor(crsr);

  background(0);

  textFont(loadFont("ArialMT-10.vlw"));

  picts = loadImages();  
  picts = monochrome(picts);
  picts = negative(picts);

  scaler = new float[picts.length];
  x = new float[picts.length];
  y = new float[picts.length];
  for(int i =0;i<scaler.length;i++){
    scaler[i] = 1.0;
    x[i] =0.0;
    y[i] =0.0; 
  }

}

void draw(){
  background(0);

  if(exposing){
    noTint();
    time++;
    if(time>=30){
      exposing=false;
      cursor(crsr);
     display=true; 
    }
  }
  else{
    tint(150,0,0); 
    time=0;
  }

  if(picts[current].width<picts[current].height){
    pushMatrix();
    rotate(radians(-90));
    pushMatrix();
    translate(-picts[current].width*scaler[current],0);
    
    pushMatrix();
    scale(1,-1);
    image(picts[current],-y[current],(-1.0*scaler[current]*picts[current].height)-x[current],
    scaler[current]*picts[current].width,
    scaler[current]*picts[current].height);
    popMatrix();
    
    popMatrix();
    popMatrix(); 

  }
  else{
    pushMatrix();
    scale(-1.0,1.0);
    image(picts[current],
    (-1.0*scaler[current]*picts[current].width)-x[current],
    y[current],
    scaler[current]*picts[current].width,
    scaler[current]*picts[current].height);
    popMatrix();  
  }

  fill(150,0,0);
  
  if(display){
  for(int i = 0;i<fileNames.length;i++){
    noStroke();    
    fill(255,0,0,150);
    if(i==current){
    rect(width-207,5+10*i,5,5);
    }
    text(fileNames[i],width-200,10+10*i); 
  }
  }

}

void keyPressed(){
  if(key == ' '&&!exposing){
    display = false;
    noCursor();
    exposing=true;
  } 
  else if(keyCode==RIGHT){
    current++;
    current=(constrain(current,0,picts.length-1));
  }
  else if(keyCode==LEFT){
    current--;
    current=(constrain(current,0,picts.length-1));
  }
  else if(keyCode == UP){
    scaler[current] += 0.01;
    scaler[current] = constrain(scaler[current],0.1,10.0);
  }
  else if(keyCode == DOWN){
    scaler[current] -= 0.01;   
    scaler[current] = constrain(scaler[current],0.1,10.0);
  }
  keyPressed=false;
  
}

void mousePressed(){
  x[current] = mouseX;
  y[current] = mouseY;  

}

void mouseDragged(){
  x[current] = mouseX;
  y[current] = mouseY;  

}



