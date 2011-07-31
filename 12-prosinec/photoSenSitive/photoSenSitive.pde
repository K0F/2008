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

float tresh = 0.1;
int cntr = 1;

int W=320,H=240;
color[] c,ac;
int bordr =10;
int rut = 30;
int dx = 2,dy =2;
boolean first = true;

boolean gotnew = false;

void setup() {
	size(640/2, 480/2);

	cam = new GSCapture(this, 640, 480, "v4lsrc");
	//new String[] {"device"}, new String[] {"/dev/raw1394"});
	r= new Recorder("out","capt");                                                                                                                                                                                                                     
	W = cam.width;
	H = cam.height;
	c = new color[W*H];
	ac = new color[W*H];
	println(W+":"+H);

	noFill();
	background(0);
}


void draw() {
	background(0);
	noFill();
	gotnew = false;
	if (cam.available()) {
		cam.read();
		if(first){
			c = cam.pixels;
			first = false;
		}else{
			c = cam.pixels;
		}
		gotnew = true;

	}

	for(int y = 0 ; y<H ;y+=dy){

		for(int x= 0 ; x<W ;x+=dx){
			stroke(ac[y*W+x]);
			point(x/2,y/2);
			if(gotnew){
				ac[y*W+x]=lerpColor(ac[y*W+x],color(brightness(c[y*W+x])),tresh);
			}
		}



	}
	
		r.add();
		//println("capture on frame :"+frameCount);
	
	//image(cam, 0, 0);
	// The following does the same, and is faster when just drawing the image
	// without any additional resizing, transformations, or tint.
	//set(160, 100, cam);

}
/*
void stop(){

	super.stop();
}*/

void keyPressed(){
	if(key=='q'){
		r.finish();
		exit();
	}

}
