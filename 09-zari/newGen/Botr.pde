class Botr{
  int id;
  int nei;
  float x,y,tx,ty,dst;
  float speed = 0.02;
  float spp = 100.0;
  float brdr = 80.0;
  
  Botr(){
    spp = random(10.0,50.0);
    //speed = random(0.01,0.09);
    
    id = gi++;
    tx=x=random(brdr,width-brdr);
    ty=y=random(brdr,height-brdr);  
  //dst = width;  
  }
  
  void run(){
    compute();
    draw();
  }
  
  void draw(){
    stroke(255,map(dst,0,width,50,0));
    line(x,y,b[nei].x,b[nei].y);
  stroke(255);
    //point(x,y);
    
  }
  
  void compute(){
    nei = neig();
    
    if(sin(frameCount/spp)<0.0){
      closer(speed);
    }else{
      further(speed);
    }
    
    border(brdr);
    
  }
  
  void closer(float a){
    
    x += a*(b[nei].x-x);
    y += a*(b[nei].y-y);
  }
  
  void further(float a){
   
    x += a*(x-b[nei].x);
    y += a*(y-b[nei].y);
  }
  
  void border(float b){
    if(x<b)x=b;
    if(x>width-b)x=width-b;
     if(y<b)y=b;
    if(y>height-b)y=height-b;
    
  }

  int neig(){
    int re = 0;
   dst = width*1.4;
    for(int i = 0;i<b.length;i++){
      float d = dist(x,y,b[i].x,b[i].y);
      if(dst>d&&i!=id){
        dst = d;
        re = b[i].id;
      }
    }
    return re;
  }  
  
  int neig2(){
    return ((id+1)%(b.length-1));
  }
}
