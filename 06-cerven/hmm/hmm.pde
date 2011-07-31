import processing.opengl.*;
int num = 10000;
Stringer s[];

//void init(){
//  frame.setUndecorated(true);
//  super.init(); 
//}

void setup(){
  size(400,200,OPENGL);
  background(0);

  s = new Stringer[num]; 

  for(int i = 0;i<num;i++){
    s[i] = new Stringer(); 
  }
  smooth();
}


void draw(){
  background(8,8,8);
  for(int i = 0;i<num;i++){
    s[i].run(); 
  }
}

class Stringer{
  float bx,by,x,y,sx,sy,phase,time,amm;
  color c;
  float step;
  float l;

  Stringer(){
    l = random(1,10);
    bx=x=sx=random(l*2,width-l*2);
    by=y=sy=random(l*2,height-l*2);
    amm=random(PI*2);
    c = color(random(255),random(255),random(255));
    step = random(-1.0,1.0);
  }

  void run(){
    compute();
    draw();
  }
  
  void compute(){
    time+=step;
    phase = amm*(sin(time/10.0)+1.0);
  }

  void draw(){
    pushMatrix();
    translate(x,y);
    rotate(phase);
    stroke(c,85);
    line(-l,0,l,0);    
    popMatrix();
  }
}
