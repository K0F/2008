import processing.video.*;

import processing.opengl.*;

Point p[];
int num = 120000;
MovieMaker mm;



void setup(){
  size(200,200,OPENGL);
  background(0); 
  p=new Point[num];
  
  frame.setTitle("wavrMovOne");
  
  for(int i = 0;i<num;i++){
   p[i] = new Point(); 
  }
  
   println("creating..");
  mm = new MovieMaker(this, width, height, "random.mov", 30, MovieMaker.H263, MovieMaker.BEST);

}

void keyPressed(){
 if(keyCode==ENTER){
   mm.finish();
   println("movie finished");
 } 
 this.exit();
  
}


void draw(){
  noStroke();
  background(0);
   for(int i = 0;i<num;i++){
   p[i].draw();
  }
  mm.addFrame();
}

class Point{
  float x,y,x2,y2;
  float bx,by;
  int it;
  float time = 0;
  float sirka = 10.0;
  float step;
  float speed = 100.0;

  Point(){
    bx=x=random(width);
    by=y=random(height);
    time=(random(100)/100.0);
    sirka = random(2.0,10.0);
    step=(random(-100,100)/1000.0);
     it = (int)random(num);
  } 

  void compute(){
    x+=((cos(time)*sirka+bx)-x)/speed*2;
    y+=((sin(time)*sirka+by)-y)/speed*2; 
    
    if(frameCount%29==0){
    it = (int)random(num);
    }
    
    x+=(p[it].x-x)/constrain(dist(p[it].x,p[it].y,x,y),1,width*2);    
    y+=(p[it].y-y)/constrain(dist(p[it].x,p[it].y,x,y),1,width*2);
    
    x-=(p[constrain(it-1,0,num)].x-x)/constrain(dist(p[it].x,p[it].y,x,y),1,width*2);    
    y-=(p[constrain(it-1,0,num)].y-y)/constrain(dist(p[it].x,p[it].y,x,y),1,width*2);

    time+=step;  
  }
  
  void draw(){
    x2=x;
    y2=y;
    compute();
    bordr((sin(frameCount/3.0)+1)*30.0);
    
    stroke(lerpColor(#FFCC00,#FFFFFF,norm(dist(x,y,x2,y2),0,1.3)),35);
    line(x,y,x+1,y); 
  }
  
  void bordr(float _kolik){
   if(x<_kolik){x=_kolik;}
  if(x>width-_kolik){x=width-_kolik;}
 if(y<_kolik){y=_kolik;}
  if(y>height-_kolik){y=height-_kolik;} 
    
  }

}
