import processing.opengl.*;


int num;
Ent[] e;

float globSpeed = 3.21f;

void setup(){
  size(400,800,OPENGL);
  background(0); 
  stroke(255,85);
  smooth();
  frame.setTitle(":: objekt #01 :: by kof");


  num = width;
  e= new Ent[num];
  for(int i =0;i<num;i++){
    e[i] = new Ent(width/2);//map(i,0,num,200,width-150)); 
  }
}


void draw(){
  //background(0);
  fill(0,55);
  rect(0,0,width,height);
  drawObjects();
}

void drawObjects(){
 pushMatrix();
 /*translate(width/2,height/2);
 rotate(frameCount/100.0);
 translate(-width/2,-height/2);*/
  scale(0.5);
  translate(width/2,height/2);
  
  for(int i =0;i<num;i++){
    e[i].run();
  }
  
  popMatrix(); 
  
}


class Ent{
  float factor;
  float x2;
  float x;
  color c;

  Ent(float _x){
    factor=random(80,300);
    x=_x; 
    c = color(lerpColor(#FFCC00,#FF1122,norm(factor,80,300)));

  }

  void run(){
    x2 = (width/2)*(sin(frameCount/(factor/globSpeed))+1)+x-width/2;
    
    //horni
   stroke(c,10); 
   line(factor,-50-factor,x2,20);
    
    //stred
    stroke(c,85);
   line(x2,45+3*sin(x2/10.0),x2,25);
   
    //dolni
    stroke(c,25);
    line(x2,50,factor,height+factor);
    
   

  }


}
