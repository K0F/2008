//
import processing.video.*;
import processing.opengl.*;

//////////////////////////////

MovieMaker mm;
int n = 1000;
AGroup[] ag = new AGroup[n];



void setup(){
  size(320,240,P3D);
  background(255);  
  for(int i = 0;i<n;i++){
   ag[i] = new AGroup(i);
  } 
  mm = new MovieMaker(this, width, height, "out/rotoshapenBatch4.mov",25, MovieMaker.BMP, MovieMaker.HIGH);
  //noSmooth();
}

void mousePressed(){
  for(int i = 0;i<n;i++){
   ag[i].reset();
  }
 mousePressed=false; 
}



public void draw(){
  background(255);
   
   for(int i = 0;i<n;i++){
   ag[i].run();
  }
  
   mm.addFrame();
}



void keyPressed(){
	if(key==' '){
		save("screen.png");
	} else if(keyCode==ENTER){
		mm.finish();
		println("hotovo!");
	}
	keyPressed=false;

}


