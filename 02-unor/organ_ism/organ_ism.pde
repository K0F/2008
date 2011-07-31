// organ_ism >> kof

import processing.opengl.*;

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
int num = 60;
Org[] org = new Org[num];
PImage shade;
//////////////////////////////////////////////////////////////////////

void setup(){
	size(1024,768,P3D);
	background(0);
	textFont(loadFont("ZapfHumanist601BTCE-Ultra-18.vlw"));
	noStroke();
	fill(255);

	frame.setTitle("gene_tics by KOF");

	shade = loadImage("shade.png");

	for(int i = 0;i<num;i++){
		org[i] = new Org(i);
	}
}

//////////////////////////////////////////////////////////////////////

void draw(){
	background(0);

	for(int i = 0;i<num;i++){
		org[i].run();
	}
}

//////////////////////////////////////////////////////////////////////

public void mousePressed(){
	if(mouseButton==LEFT){
		for(int i = 0;i<num;i++){
			if(dist(org[i].x,org[i].y,mouseX,mouseY)<50){
				org[i].grow();
				org[i].mutate();
			}
		}
	}else{
		for(int i = 0;i<num;i++){
			org[i] = new Org(i);
		}

	}

}

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////


