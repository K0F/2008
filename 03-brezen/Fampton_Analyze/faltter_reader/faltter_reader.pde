import processing.opengl.*;


Reader r;
PFont f;

void setup(){
	size(screen.width,screen.height,OPENGL);
	background(0);
	f = loadFont("Tahoma-9.vlw");
	textFont(f);
	frame.setLocation(0,0);
	r = new Reader("Carrots__Peas"); //Carrots__Peas//Apparatus_sum
	strokeWeight(1);
	noFill();
}

void init(){
	frame.setUndecorated(true);
	super.init();
	
}


void draw(){
	background(0);
	r.compute();
	for(int i = 0;i<height;i+=10){
		stroke(0);
		line(0,i,width,i);
	}
	fill(255);
	text(r.zalomeni,r.zalomeni+10,15);
	text(r.shift,10,15);
}

void keyPressed(){
	if(keyCode==LEFT){
		r.shift--;
	}else if(keyCode==RIGHT){
		r.shift++;
	}
	r.shift=constrain(r.shift,0,r.len-1);

}
