import processing.opengl.*;

Cube cub;

void setup(){
	size(400,200,P3D);
	background(255);
	 //hint(ENABLE_OPENGL_2X_SMOOTH);                                                               
	 cub=  new Cube();
	smooth();
	fill(255,200);
	frame.setAlwaysOnTop(true);
}


void draw(){
	background(255);
//	fill(255,72);
//	rect(0,0,width,height);
	
	cub.draw();
	
}

