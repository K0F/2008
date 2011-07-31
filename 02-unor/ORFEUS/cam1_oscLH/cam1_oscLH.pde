/**
* 
* Orfeus Tracker 1 by kof
*
*
*/

////////////////////////////////////////////////////////////////////////////////// Main
import processing.opengl.*;
import oscP5.*;
import netP5.*;
//////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////
PFont font;
Player player;
Director dir;
CPanel cp;
Oblast[] senzor = new Oblast[9];
int sendId;
//////////////////////////////////////////////////////////////////////////////////

void setup(){
	size(450,360,OPENGL); //
	background(0);

	player = new Player(this,25,1,12,2,2); //tolerance, interval,nastroj,modNastroje,MidioutKanal
	cp = new CPanel(170,0);
	dir = new Director();

	float xes[] = {0 , (width+20)/3 , (width+20)/3*2};
	float yes[] = {0 , height/3 , height/3*2};

	int modX = 120, modY = 100;

	for(int i  =0;i<senzor.length;i++){
		if(1+i!=5){
			senzor[i] = new Oblast(xes[i%3],yes[i/3],modX,modY,i+1);
		}
	}

	/*
	for(int x = 0;x<width;x+=modY){
			for(int y = 0;y<height;y+=modX){

			}
			}
		
		senzor[y*width+x] = new Oblast(x,y,80,80,y*width+x);
	*/



	frameRate(25); //!!!!

	//-----------------------* frame icon
	String path = sketchPath("data/ico.gif");
	path.replace('\\','/');
	Image img = getToolkit().getImage(path);
	frame.setIconImage(img);
	//-----------------------* frame title
	frame.setTitle("orfeusTracker 1.14 mod :: kof");
	//-----------------------*
	frame.show();

	//rectMode(CENTER);

	font = loadFont("Uni0553-8.vlw");
	textFont(font, 8);
	println("/////////////////////////////////////");
	println("this world is soo weird so let's play!");
	println("/////////////////////////////////////");
}

//////////////////////////////////////////////////////////////////////////////////

void draw(){
	background(0);
	player.draw();
	cp.run();
	for(int i =0;i<senzor.length;i++){
		if(1+i!=5){
			senzor[i].run();
		}
	}
	dir.compute();

}

//////////////////////////////////////////////////////////////////////////////////



void oscEvent(OscMessage theOscMessage) {
	/* print the address pattern and the typetag of the received OscMessage */
	print("### received an osc message.");
	print(" addrpattern: "+theOscMessage.addrPattern());
	println(" typetag: "+theOscMessage.typetag());
}
