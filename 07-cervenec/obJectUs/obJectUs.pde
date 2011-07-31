//import processing.opengl.*;

float X,Y,speed = 30;

Biz[] bb;
Recorder r;

void setup(){
  int h = 400;
  int w = (int)(h*1.422);

 size(460,240);
  background(0);

  bb = new Biz[40];
  r = new Recorder("out","kruhy2.avi");
  for(int i = 0;i<bb.length;i++){
    bb[i] = new Biz((i/10.0)); 
  }

  smooth();

  X=width/2;
  Y=height/2;
}

void arrow(){

}

void draw(){
  background(0);

  for(int i = 0;i<bb.length;i++){
    bb[i].draw(); 

  }





  X+=(mouseX-X)/speed;
  Y+=(mouseY-Y)/speed;
  r.add();
}

void keyPressed(){
 if(key=='q'){
  r.finish();
   exit();
 } 
  
}
