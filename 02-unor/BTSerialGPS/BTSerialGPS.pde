/*gps evolve raw:

 $GPGGA,233838.938,5007.652015,N,01425.290050,E,0,0,,319.429,M,45.512,M,,*48
 $GPGSA,A,1,,,,,,,,,,,,,,,*1E 
 $GPRMC,233838.938,V,5007.652015,N,01425.290050,E,0.000,0.00,270208,,,N*41 
 $GPVTG,0.00,T,,M,0.000,N,0.000,K,N*32
 
 prog:by:kof
 */
import processing.opengl.*;
import processing.serial.*;

PFont font;
GpsViz gps;

////  ///////////////// >
void setup(){
	size(400,400,OPENGL);
	frameRate(15);

	frame.setTitle("GPS - GPGGA test");

	font = loadFont("Verdana-9.vlw");
	textFont(font);
	
	background(0);
	fill(255);
	text("connecting ...",10,20);

	gps = new GpsViz(this,6,9600); //?
}

void draw(){
	background(0);
	gps.run();
}

////  ///////////////// >
void keyPressed(){
	if((key == CODED)&&(keyCode==ESC)){
		this.stop();
	}
	keyPressed = false;
}

void mousePressed(){
	if(mouseButton==LEFT){
		gps.resetVars();
	}
	mousePressed=false;
}

////  ///////////////// >
public void stop() {
	gps.in.stop();
	super.stop();
	this.exit();
}




