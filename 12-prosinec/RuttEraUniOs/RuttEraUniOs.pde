/**
 * Getting Started with Capture.
 * 
 * GSVideo version by Andres Colubri. 
 * 
 * Reading and displaying an image from an attached Capture device. 
 */ 
import codeanticode.gsvideo.*;
//import processing.opengl.*;

GSCapture cam;
Recorder r;
boolean rec = true;

int W=320,H=240;
color[] c;
int bordr =10;
int rut = 30;
int dx = 1,dy =3;

void setup() {
  size(640, 480,P3D);
	
  // With GSVideo there is not method to select the capture device, yet.
  //cam = new GSCapture(this,640,480,"v4lsrc");
  cam = new GSCapture(this, 640, 480, "v4lsrc");//new String[] {"device"}, new String[] {"/dev/raw1394"});
  W = cam.width;
  H = cam.height;
  c = new color[W*H];
  println(W+":"+H);
  
  if(rec)
  r = new Recorder("out","mee.avi");
  noFill();
  background(0);
}


void draw() {
  //background(0);
  fill(0,35);
  rect(-1,-1,width+2,height+2);
  noFill();
  
  if (cam.available()) {
    cam.read();
        c = cam.pixels;;

    //cam.loadPixels();
  }
    
    for(int y = 0 ; y<H ;y+=dy){
      beginShape();
      for(int x= 0 ; x<W ;x+=dx){
        stroke(color(c[y*W+x]),195);
        vertex(map(x,0,W,bordr,width-bordr),map(y,0,H,bordr,height-bordr)-map(brightness(c[y*W+x]),0,255,-rut,rut));
        
      }
      endShape();
    }
     if(rec)
    r.add();
    //image(cam, 0, 0);
    // The following does the same, and is faster when just drawing the image
    // without any additional resizing, transformations, or tint.
    //set(160, 100, cam);
  
} 
/*
void stop(){

	cam.stop();
	super.stop();
}*/

void keyPressed(){
	if(key=='q'){
	 if(rec)
		r.finish();
		exit();
	}

}
