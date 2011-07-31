
/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

float koef,lim0,lim1,x,y,z;
int ident;
float Y[];

float hustota = 10.0;

OscP5 oscP5;
NetAddress myRemoteLocation;


void setup() {
	size(400,600);
	frameRate(25);
	/* start oscP5, listening for incoming messages at port 12000 */
	
	Y = new float[(int)hustota+1];
	                                                 
	oscP5 = new OscP5(this,12000);                                                                                                                                                                               
	
	textFont(createFont("Veranda",9));
}


void draw() {
	//background(255);
	fill(255,15);
	rect(0,0,width,height);

	beginShape();
	int cntr = 0 ;
	for(float f = -lim0 ;f<lim1;f+=(lim1+lim0)/hustota){
		Y[cntr] = koef*f*f;
		rect(map(f,-lim0,lim1,0,width),map(Y[cntr],-50,50,height,0),3,3);
		vertex(map(f,-lim0,lim1,0,width),map(Y[cntr],-50,50,height,0));
		cntr++;
		
		
	}
	endShape();
	//println(Y);
	fill(0);
	text(" values: "+ident+", "+koef+", "+lim0+", "+lim1+", "+x+", "+y+", "+z,10,10);
}


void oscEvent(OscMessage theOscMessage) {
	/* check if theOscMessage has the address pattern we are looking for. */

	if(theOscMessage.checkAddrPattern("/msg")==true) {
		/* check if the typetag is the right one. */
		if(theOscMessage.checkTypetag("isfffff")) {
			/* parse theOscMessage and extract the values from the osc message arguments. */
			ident = theOscMessage.get(0).intValue();
			koef = parseFloat(theOscMessage.get(1).stringValue());
			lim0 = theOscMessage.get(2).floatValue();
			lim1 = theOscMessage.get(3).floatValue();
			x = theOscMessage.get(4).floatValue();
			y = theOscMessage.get(5).floatValue();
			z = theOscMessage.get(6).floatValue();

			//  println(" values: "+ident+", "+koef+", "+lim0+", "+lim1+", "+x+", "+y+", "+z);
			return;
		}
	}
	//println("### received an osc message. with address pattern "+theOscMessage.addrPattern());
}

//

