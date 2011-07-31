//import processing.opengl.*;

int ID = 0;
int num = 50;
Bosson[] b;
Collider cld;
Recorder rr;

float [][] path;
int checkPoint = 0;
int nb = 1000;

void init(){
  //frame.setUndecorated(true);
  super.init(); 
}

void setup(){
  //frame.setLocation(0,0);
  size(screen.width/2,screen.height/2,P3D);
  b = new Bosson[num];
  ellipseMode(CENTER);
  frameRate(25);

  path = new float[nb][2];
  for(int i = 0;i<nb;i++){
    for(int e = 0;e<path[i].length;e++){
      if(e==0){
        path[i][e] = random(width);
      }
      else{
        path[i][e] = random(height);
      }

    }

  }

  for(int i = 0;i<num;i++){
    b[i] = new Bosson();    
  }

  textFont(createFont("Tahoma",9));


  cld = new Collider(b);  
  //rr= new Recorder("out","race1");
  background(255);
}


void draw(){
  background(15);
  //fill(255,5);
  //rect(0,0,width,height);

  for(int I = 0;I < num;I++){
    b[I].run(); 
  }

  cld.run();

  //rr.add();
}






