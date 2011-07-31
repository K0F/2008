import processing.video.*;
import processing.opengl.*;

Rezonant r[];
MovieMaker mm;

void setup(){
  size(300,300,OPENGL);
  background(0); 
  noFill();
  
  println("creating..");
  mm = new MovieMaker(this, width, height, "soThatsMath.mov",25, MovieMaker.PNG, MovieMaker.HIGH);

  
  r = new Rezonant[50000];
  for(int i = 0;i<r.length;i++){
    r[i] = new Rezonant(i); 
  }
  println("done!");
}

void draw(){
  //background(0);
 fill(0,15);
 rect(0,0,width,height);
   
  for(int i = 0;i<r.length;i++){
    r[i].run();   
  } 
  
  mm.addFrame();
}

void keyPressed(){
 if(keyCode == ENTER){
   println("moive finished");
 }   
}

void stop(){
  mm.finish();
  super.stop();

}

class Rezonant{
  float faze,sx,sy,x,y,rychlost,delka,s,dista;
  int id,last = 0;
  color c;
  
  Rezonant(int _id){
    id = _id;
    sx = random(width);
    sy = random(height);
    x=sx;
    y=sy;
    rychlost =random(-1.5,1.5);
    faze = random(0.0,1.0);
    delka = random(width*.2151);
    s = 10.0;//random(8.1,20);
    c = color(255);//lerpColor(#000000,#FFFFFF,norm(x,0,width));   
  }

  void run(){
    compute();
    draw() ;
  }

  void compute(){    
    faze+=rychlost;
    x=cos(faze/s)*delka+sx;
    y=sin(faze/s)*delka+sy;
    int cnt = 0;
    for(int i = 0;i<r.length;i++){
         
     dista = dist(x,y,r[i].x,r[i].y);
    if(dista<20.0){
     //last=i;
     getVals(i);
     break;
      
    } else if(cnt>500){
     break; 
    }else{
     cnt++; 
    }
    }
    
  } 
  
  void getVals(int ID){
    dista = constrain(dista,1.001,width);
    rychlost += (r[ID].rychlost-rychlost)/dista;
    delka += (r[ID].delka-delka)/dista;
  }

  void draw(){
    stroke(c,25);
    line(x,y,x+1,y);
  } 
}
