RAT rat[];


void setup(){
  size(300,300);
  background(0);
  
  rat = new RAT[width];
  
  for(int i = 0;i<rat.length;i++){
   rat[i] = new RAT(3.031,i); 
  }
  
  frame.setTitle("~sin~");
  
}

void draw(){
 fade(#000000,15);
    
    for(int i = 0;i<rat.length;i++){
   rat[i].run(); 
    
  }
  
  
}

void fade(color _c,int _f){
 fill(_c,_f);
  rect(0,0,width,height);   
}

class RAT{
  float x,y,tx,ty;
  float speed = 10.10;
  float dista;
  int id;
  float time,step;;
  
 RAT(float _speed,int _id){
  id=_id;
  tx=x=id;
  speed=_speed;
  y=0;  
  step=(x/(width+1.0))*10.001;//random(0.001,0.005);
 } 
 
 void run(){
   compute();
   draw();
   
 }
 
 void compute(){
  time+=step;
  ty+=(((sin(time/10.0)+1)*height/2.0)-ty)/speed;
  y+=(ty-y)/speed ;
    att();
 }
 
 void att(){
   if(id!=0){
    dista = dist(rat[id-1].x,rat[id-1].y,x,y);
    dista =constrain(dista,1.01,height);
     ty+=(rat[id-1].y-ty)/(speed);
  }
  
  if(id!=rat.length-1){
    dista = dist(rat[id+1].x,rat[id+1].y,x,y);
    dista =constrain(dista,1.01,height);
     ty+=(rat[id+1].y-ty)/speed;
  } 
   
 }
 
 void draw(){
   stroke(255);
   point(x,y);
   stroke(255,0,0,155);
   point(tx,ty);
   stroke(0,255,0);
   point(tx,(((sin(time/10.0)+1)*height/2.0)));
   noStroke();   
 }  

}
