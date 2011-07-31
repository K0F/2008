import processing.video.*;

Rezonant r[];
PrintWriter output;
boolean writing = false;
MovieMaker mm;

void setup(){
  size(320,240,P3D);
  background(0); 
  noFill();
  
  mm = new MovieMaker(this,width,height,"out85.mov",30,MovieMaker.JPEG,MovieMaker.BEST);
  
  r = new Rezonant[50000];
  for(int i = 0;i<r.length;i++){
    r[i] = new Rezonant(i); 
  }
  
  output = createWriter("trackTest.txt"); 
  output.println("P5 track1");
  output.println("Frame             X             Y   Correlation");

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
  write(); 
  mm.addFrame();
}

void write(){
 //point(mouseX, mouseY);
  output.println("   "+((int)frameCount)+".00        "+(float)r[r.length-1].x+"        "+(float)(height-r[r.length-1].y)+"         "+0.80); // Write the coordinate to the file 
  
}

void keyPressed(){
 if(keyCode == ENTER){
  mm.finish();
  println("moive finished");
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  exit(); // Stops the program
 } 
  
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
    delka = random(width*.151);
    s = 10.0;//random(8.1,20);
    if(id==r.length-1){
      c = color(#FF0000);
    }else{
    c = lerpColor(#FFCC00,#FFFFFF,norm(x,0,width));
    }
    
   
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
    
    for(int i = 0;i<r.length;i++){
      /*if(dist(x,y,r[last].x,r[last].y)<width*.151/2.0){
        getVals(last);
     break;
      }*/
      
     dista = dist(x,y,r[i].x,r[i].y);
    if(dista<50.0){
     //last=i;
     getVals(i);
     break;
      
    } 
    }
    
  } 
  
  void getVals(int ID){
    dista = constrain(dista,1.001,5);
    rychlost += (r[ID].rychlost-rychlost)/dista;
    delka += (r[ID].delka-delka)/dista;
   //s+=(r[ID].s-s)/dista;
    
  }

  void draw(){
    stroke(c,35);
    point(x,y);
    if(id == r.length-1){
      stroke(c);
     line(x-5,y,x+5,y); 
     line(x,y-5,x,y+5);
    }
  } 
}
