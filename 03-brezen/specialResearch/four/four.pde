import processing.opengl.*;
Vale[] v;
int num = 5000;

void setup(){
	size(800,800,OPENGL);

	frame.setTitle("four #4");
	background(#ffffff);
	stroke(0,15);
	noFill();
	smooth();

	v = new Vale[num];

	for(int i = 0;i<v.length;i++){
		v[i] = new Vale();
	}

}

void draw(){
	for(int i = 0;i<v.length;i++){
		v[i].draw();
		
	}



	if(frameCount%50==0){
		int kdo = (int)(random(0,v.length-1));
		reset(kdo);
	}
}

void mousePressed(){
	if(mouseButton==LEFT){
		background(#ffffff);
	}else{
		int kdo = (int)(random(0,v.length-1));
		reset(kdo);
	}
}

void reset(int kdo){
	v[kdo].softReset();
}

void keyPressed(){
	save("screen.png");
}



