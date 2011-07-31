import processing.video.*;

import processing.opengl.*;

Rezonant r[];
MovieMaker mm;

void setup(){
  size(200,200,P3D);
  background(0); 
  noFill();
  
  mm = new MovieMaker(this,width,height,"matterg.mov",30,MovieMaker.JPEG,MovieMaker.HIGH);
  
  r = new Rezonant[100000];
  for(int i = 0;i<r.length;i++){
    r[i] = new Rezonant(i); 
  }

}


void draw(){
 // background(0); 
 fill(0,15);
 rect(0,0,width,height);

  //beginShape();
  for(int i = 0;i<r.length;i++){
    r[i].run();
    //stroke(255,55);
    //vertex(r[i].x,r[i].y);

  }
  //endShape();

  mm.addFrame();
}

void keyPressed(){
 if(keyCode == ENTER){
  mm.finish();
  println("moive finished");
 } 
  
}



class Rezonant{
  float faze,sx,sy,x,y,rychlost,delka,s,dista;
  int id,last = 0;
  float tresh = 45.0;
  float dominance;
  color c;
  
  Rezonant(int _id){
    id = _id;
    sx = random(width);
    sy = random(height);
    x=sx;
    y=sy;
    rychlost =random(-1000.5,1000.5);
    faze = random(-100.0,100.0);
    delka = random(-tresh*2.0214,tresh*2.0214);
    dominance = random(1.0,50.0);
    s = 10000.0;//random(8.1,20);
   // c = lerpColor(#000000,#FFFFFF,0.5); 
  y=/*sin(faze/s)*delka+*/sy;  
  }

  void run(){
    compute();
    draw() ;
  }

  void compute(){
    //delka = pow(dist(x,y,mouseX,mouseY)/4.0,.8);
    faze+=rychlost;
    x=cos(faze/s)*delka+sx;
    y=sin(x/100.0)*delka+sy;
    int cnt = 0;
    for(int i = 0;i<r.length;i++){
      /*if(dist(x,y,r[last].x,r[last].y)<width*.151/2.0){
        getVals(last);
     break;
      }*/
      
     dista = dist(x,y,r[i].x,r[i].y);
    if(dista<tresh){
     //last=i;
     getVals(i);
     break;
      
    } else if(cnt>500){
     break; 
    }else{
     cnt++; 
    }
    }
    c= lerpColor(#FFFFFF,#000000,(sin(faze/s)+1)/2.0);
    
  } 
  
  void getVals(int ID){
    dista = constrain(dista,1.001,width);
    rychlost += (r[ID].rychlost-rychlost)/(dista*dominance);
    delka += (r[ID].delka-delka)/(dista*dominance);
    //y+=(r[ID].y-y)/(dista*dominance);
   //s+=(r[ID].s-s)/dista;    
  }

  void draw(){    
    stroke(c,25);
    line(x,y,x+1,y);
  } 
}
