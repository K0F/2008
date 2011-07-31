import processing.video.*;
import processing.opengl.*;

//////////////////////////////
boolean record = true;

MovieMaker mm;
int n = 1000;
AGroup[] ag = new AGroup[n];



void setup(){
  size(1280,720,P3D);
  background(255);
  for(int i = 0;i<n;i++){
    ag[i] = new AGroup(i);
  }
  if(record){
    mm = new MovieMaker(this, width, height, "out/rotoshapenBatch4.mov",25, MovieMaker.JPEG, MovieMaker.HIGH);
  }	
  //noSmooth();
  textFont(createFont("Arial",182));
}



void mousePressed(){
  for(int i = 0;i<n;i++){
    ag[i].reset();
  }
  mousePressed=false;
}



void draw(){
  background(255);

  for(int i = 0;i<n;i++){
    ag[i].run();

  }
  if(record){
  mm.addFrame();
  }
}

void stop(){
  if(record){
  mm.finish();
  }
  super.stop();

}



void keyPressed(){
  if(key==' '){
    save("screen.png");
  } 
  else if(keyCode==ENTER){
    if(record){
    mm.finish();
    println("hotovo!");
    }
  }
  keyPressed=false;

}


