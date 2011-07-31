//import processing.opengl.*;

int ID;

Seeker[] a = new Seeker[500];
Recorder rr;

void setup(){
  size(640,280,P3D);
  for(int i =0;i<a.length;i++){
    a[i] = new Seeker();
  }
  println(ID);
  background(255);
  rr= new Recorder("out","micro2");

}


void draw(){
  fill(255,5);
rect(0,0,width,height);
  for(int i =0;i<a.length;i++){
    a[i].run();
  }
rr.add();

}


void keyPressed(){
 if(key == 'q'){
  rr.finish();
  println("moive finished");
  exit();
 } 
  
}

class Seeker{
  float X,Y,tx,ty;
  float speed = 2;
  int id;
  int cyclon;

  Seeker(){
    id=ID;
    ID++;
    tx=X=random(width);
    ty=Y=random(height);
    cyclon = (int)random(3,1300);
  }


  Seeker(float _x,float _y){
    id=ID;
    ID++;
    tx=X=_x;
    ty=Y=_y;
    cyclon = (int)random(3,1300);
  }

  void getCoord(){
    for(int x = 0;x<width;x++){
      int xx = (int)random(width);
      for(int y = 0;y<height;y++){
        int yy = (int)random(height);
        if(brightness(get(xx,yy))<40&&dist(xx,yy,X,Y)>20){
          tx=xx;
          ty=yy;
          //println(id+":: cycle");
          return;
          
        }
      }
    }
  }
  
  void detract(){
    for(int i = 0;i<a.length;i++){
      if(random(a.length*10)<1&&id!=i){
      Y-=(a[i].Y-Y)/(100.0);  
      X-=(a[i].X-X)/(100.0);
      return;
      }
    }
    
  }

  void run(){
    detract();
    if(frameCount%cyclon==0){
      getCoord();
    }

    X+=(tx-X)*(speed/1000.0);
    Y+=(ty-Y)*(speed/1000.0);

    draw();
  }

  void draw(){
    noStroke();
    fill(0,15);
    rect(X,Y,2,2);
  }

}

