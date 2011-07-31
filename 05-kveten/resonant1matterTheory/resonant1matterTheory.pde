import processing.opengl.*;

Rezonant r[];
//MovieMaker mm;

void setup(){
  size(200,200,OPENGL);
  background(0); 
  noFill();
  
  //mm = new MovieMaker(this,width,height,"out44.mov",30,MovieMaker.JPEG,MovieMaker.HIGH);
  
  r = new Rezonant[10000];
  for(int i = 0;i<r.length;i++){
    r[i] = new Rezonant(i); 
  }

}


void draw(){
  background(0); 

  //beginShape();
  for(int i = 0;i<r.length;i++){
    r[i].run();
    //stroke(255,55);
    //vertex(r[i].x,r[i].y);

  }
  //endShape();

  //mm.addFrame();
}

void keyPressed(){
 if(keyCode == ENTER){
  //mm.finish();
  println("moive finished");
 } 
  
}



class Rezonant{
  float faze,sx,sy,x,y,rychlost,delka,s,dista;
  int id,last = 0;
  float tresh = 45.0;
  color c;
  
  Rezonant(int _id){
    id = _id;
    sx = random(width);
    sy = random(height);
    x=sx;
    y=sy;
    rychlost =random(-10.5,10.5);
    faze = random(-1.0,1.0);
    delka = random(-tresh*0.2,tresh*0.2);
    
    s = 10.0;//random(8.1,20);
    c = lerpColor(#FFCC00,#FFFFFF,norm(x,0,width));   
  }

  void run(){
    compute();
    draw() ;
  }

  void compute(){
    //delka = pow(dist(x,y,mouseX,mouseY)/4.0,.8);
    faze+=rychlost;
    x=cos(faze/s)*delka+sx;
    y=sin(faze/s)*delka+sy;
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
    
  } 
  
  void getVals(int ID){
    dista = constrain(dista,1.001,width);
    rychlost += (r[ID].rychlost-rychlost)/dista;
    delka += (r[ID].delka-delka)/dista;
   //s+=(r[ID].s-s)/dista;    
  }

  void draw(){    
    stroke(c,155);
    line(x,y,x+1,y);
  } 
}
