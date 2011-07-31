import processing.opengl.*;

Cwd cwd;

void setup(){
  size(200,200,OPENGL);
  background(255);
  cwd = new Cwd((int)(5000)); 
  stroke(0,15);
  
  //smooth();
}

void draw(){
  background(255);
  cwd.run(); 
/*  if(frameCount%30==0){
     cwd.changeDir();
  }*/
}

void mousePressed(){
  cwd.changeDir();
}


class Cwd{
  ArrayList a;
  int num;

  Cwd(int _num){
    num=_num;
    a = new ArrayList();
    for(int i = 0;i<num;i++){
      addNew();
    } 
  }

  void run(){
    for(int i =0;i<a.size();i++){
      Part q = (Part)a.get(i);       
      q.run();
    }
  }
  
  void changeDir(){
    for(int i =0;i<a.size();i++){
      Part q = (Part)a.get(i);       
      q.changeDir();
    }
  }
  /*
  void addNew(int _id,float _x,float _y){    
   a.add(new Part(a,_id,_x,_y));
   }
   
   void addNew(int _id){    
   a.add(new Part(_id));
   }
   */
  void addNew(){    
    a.add(new Part());
  }

}

class Part{
  float x,y;
  float uhel,rychlost;
  float r = 80; 
  float dir = 1f;//randDir();
  
  Part(){
    x=random(-r,width+r);
    y=random(-r,height+r);
    uhel = random(-PI,PI);
    rychlost=random(.003,0.001)*dir;
  }


  void run(){
   // rychlost+=0.05*((map(dist(mouseX,mouseY,x,y),width*1.14,0,0.0001,0.03)*dir)-rychlost);

    pushMatrix();
    translate(x,y);
    rotate(uhel);
    uhel+=rychlost;
    line(-r,0,r,0);
    popMatrix();

  }
  void changeDir(){
   //dir*=-1.0f; 
   rychlost*=-1.0f;
  }

  float randDir(){
    int q = (int)random(0,1000);
    if(q<500){
      return -1.0;
    } 
    return 1.0;
  }

}
