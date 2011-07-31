 Attractor a;
GOD god;

void setup(){
  size(400,400);
  background(0); 
 
  a = new Attractor();
  god = new GOD(50);  
}

void draw(){
  background(0);
  stroke(255);
  fill(255);
   a.move();
  god.run();
}

public class GOD{
 
  Bytost b[];

  int num;
  
  GOD(int _num){
    num=_num;
    b = new Bytost[num];
    
    for(int t =0;t<num;t++){
      b[t]=new Bytost(t,num,this);
    }
    
  }

  void run(){
   
    for(int t =0;t<num;t++){
      b[t].move();
      b[t].draw();
    }

  }


}

public class Bytost{
  float x,y,tx,ty;
  int id;
  float dista;
  float speed = 5.0; 
  int num;
  Object o ;
  
  Bytost(int _id,int _num){   

    this.num=_num; 
    id=_id;
    x=tx=random(width);
    y=ty=random(height); 
  }

  void run(){

    
  }

  void move(){
    dista = dist(a.x,a.y,x,y);
    dista = constrain(dista,1,width*height);
    tx+=(a.x-tx)/(speed*5.0);
    ty+=(a.y-ty)/(speed*5.0);

    x+=(tx-x)/speed;    
    y+=(ty-y)/speed;
    
  }

  void draw(){
    point(x,y); 

  }

}

class Attractor{
  float x,y;
  
  void move(){
    x=mouseX;
    y=mouseY;
    rect(x,y,2,2);
  } 


}
