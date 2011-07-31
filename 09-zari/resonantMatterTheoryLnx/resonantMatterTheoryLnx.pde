//import processing.opengl.*;


Rezonant r[];
//MovieMaker mm;
Recorder rr;

void setup(){
  size(800,550,P2D);
  background(0); 
  noFill();
  rr= new Recorder("vids","tets3");
  
  //mm = new MovieMaker(this,width,height,"matterg.mov",30,MovieMaker.JPEG,MovieMaker.HIGH);
  
  r = new Rezonant[1000];
  for(int i = 0;i<r.length;i++){
    r[i] = new Rezonant(i); 
  }

}


void draw(){
 // background(0); 
 fill(0,55);
 noStroke();
 rect(0,0,width,height);

  //beginShape();
  for(int i = 0;i<r.length;i++){
    r[i].run();
    //stroke(255,55);
    //vertex(r[i].x,r[i].y);
  }
  
  //if(frameCount>330){
  rr.add();
  //}*/
  //endShape();

  //mm.addFrame();
}

void keyPressed(){
 if(key == 'q'){
  rr.finish();
  println("moive finished");
  exit();
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
    noFill();//fill(c,25);
    stroke(255,15);
    rect(x,y,3,3);
  } 
}
