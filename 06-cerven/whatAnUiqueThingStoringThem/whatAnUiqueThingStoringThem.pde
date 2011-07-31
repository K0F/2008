import processing.opengl.*;

Part p[];

color bck = #121B2E;

void setup(){
  size(400,400,OPENGL);
  background(bck);
  noFill();
  stroke(255,85);

  p=new Part[200];

  for(int i = 0;i<p.length;i++){
    p[i] = new Part(i);
  } 

  smooth();

}

void draw(){
  //background(bck);
  fill(bck,2);noStroke();
  rect(0,0,width,height);
  noFill();
  for(int i = 0;i<p.length;i++){
    p[i].draw(); 
  }

}

class Part{
  float x,y,sx,sy;
  float okruh = 25.0;
  float siz;
  float speed = 30.0;
  int id;
  int neighs[];
  boolean firstRun = true;
  float tension;
  color c;
  int time;
  float cycle;

  Part(int _id){
    id=_id;
    sx=x=random(width);
    sy=y=random(height);
    siz = random(15,25);
    okruh = siz/2;
    time = (int)random(0,1000);
    cycle = random(15,30);
  }

  void draw(){
    time++;
    compute();
    bordr(0);
    stroke(c,55);
    ellipse(sx,sy,okruh*2,okruh*2);

  }

  void compute(){
    
    okruh=(siz/2)*(sin(time/cycle)+1.1);
    
    
    if(firstRun){
      neighs = getNeighs();
      firstRun=false; 
    }

    float dista;
    tension = 0;
    int cnt = 0;
    for(int i = 0;i<p.length;i++){
      dista = dist(x,y,p[i].x,p[i].y);
      if(dista<okruh+p[i].okruh&&id!=i){
        x-=(p[i].x-x)/(okruh*dista/130.0+1f);
        y-=(p[i].y-y)/(okruh*dista/130.0+1f);
        tension+=dista-okruh;
        cnt++;
      }else if(dista<1.5*(okruh+p[i].okruh)&&id!=i){
        x+=(p[i].x-x)/(okruh*dista/8.0+1f);
        y+=(p[i].y-y)/(okruh*dista/8.0+1f);
      }  
      }
      
      tension/=(cnt+1f);
      tension = constrain(tension,0,okruh);
      c = lerpColor(#FFFFFF,#FF0000,norm(tension,0,okruh));
      if(id==0){
       // println(tension+"  "+okruh);
      }
      
      sx+=(x-sx)/speed;
      sy+=(y-sy)/speed;

    /*
    for(int i = 0;i<neighs.length;i++){
     if(dist(x,y,p[i].x,p[i].y)<siz/2+p[i].siz/2){
     x-=(p[i].x-x)/speed;
     y-=(p[i].y-y)/speed;       
     }
     else if(dist(x,y,p[i].x,p[i].y)>siz/2+p[i].siz/2){
     //line(p[i].x,p[i].y,x,y);
     neighs = null;
     neighs = getNeighs(); 
     break;
     }
     }
     */
  }

  void bordr(int kolik){
    if(x+okruh>width-kolik){
      x=width-kolik-okruh;
    } 
    if(x-okruh<kolik){
      x=kolik+okruh;
    }
    if(y+okruh>height-kolik){
      y=height-kolik-okruh;
    } 
    if(y-okruh<kolik){
      y=kolik+okruh;
    }

  }

  int[] getNeighs(){
    int [] ns = new int[0];
    for(int i = 0;i<p.length;i++){
      if(dist(x,y,p[i].x,p[i].y)<okruh&&i!=id){
        ns = (int[])expand(ns,ns.length+1);
        ns[ns.length-1] = i;        
      }

    } 
    return ns;
  }

}
