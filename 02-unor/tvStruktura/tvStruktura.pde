import processing.opengl.*;

import JMyron.*;


int rat = 20;
int numX=4*rat,numY=3*rat;
int sX,sY;
int mx,mn = 500;
int img[],img2[];
int X = 0;
JMyron m;

void setup(){
  size(screen.width,numY,OPENGL);
  m = new JMyron();//obj
  m.start(numX,numY);//45,36);//320x240
  m.findGlobs(0);
  
  sX = width/numX;
  sY = height/numY;
  
  img = new int[numX*numY];
  img2 = new int[numX*numY];
  noStroke();
  
  frame.setLocation(0,screen.height/2); //works
  background(0);
}

public void init(){
 frame.setUndecorated(true);
 super.init(); 
  
  
}

void draw(){
  X++;
  
  img2 = img;//m.image();
  m.update();
  img = m.image();
  int q = 0;
  
  for(int x = 0; x<numX;x++){
     for(int y = 0; y<numY;y++){
       q = abs(img[y*numX+x]-img2[y*numX+x]);
       if(q>mx)mx=q;
       if(q<mn)mn=q;
       q = (int)map(q,mn,mx,0,255);
       fill(0,1);
       if (q > 80){
        fill(color(img[y*numX+x])); 
       }
       rect(x+X,y,2,2);
     }    
  }
  //println(q);
  
  
  
}
