import processing.opengl.*;

Circle q;


float res;
int dev;


void init(){
frame.setUndecorated(true);
super.init();
}

void setup(){
  frame.setLocation(500,0);
  size(800,800,OPENGL);
  
  background(0);
  stroke(255,5);
  noFill();
  smooth();

  q = new Circle(width/2,height/2,width/2);
  
  textFont(createFont("Tahoma",9));
  
  res = 0.0;
  dev =1;
  

}


void draw(){
 // background(0);
 res += 0.001*(((sin(frameCount/1000.0)+1)+0.0001)-res);
 
 stroke(255,5);
 
 beginShape();
  for(float w = 0;w<=1;w+=res){
    vertex(q.getPnt(w)[0],q.getPnt(w)[1]);
  }
  endShape(); 
  
  fill(0);
  noStroke();
  rect(0,0,50,10);
  fill(255);
  text(frameCount,10,10);
  noFill();
  
  if(frameCount!=0&&frameCount%1000 == 0&&frameCount!=0){
   save("2circle_"+dev+".png"); 
   dev++;
  }
  
}




class Circle{
  float cx,cy;
  float radi;

  Circle(float _cx,float _cy,float _radi){
    cx=_cx;
    cy=_cy;
    radi=_radi;
  }

  float[] getPnt(float in){
    float inn = map(in,0,1,0,TWO_PI);
    float x,y;
    x=cx+(cos(inn)*radi);
    y=cy+(sin(inn)*radi);
    float[] answ = new float[2];
    answ[0] = x;
    answ[1] = y;
    return answ;
  }
}
