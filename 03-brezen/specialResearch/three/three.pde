import processing.opengl.*;
import processing.*;

Weird w;

void setup(){
	size(400,400,P3D);
	background(0);
	stroke(255,5);
	
	w = new Weird(2);
}



void draw(){
	background(0);
	
	
}

class Weird{
	int num;
	
	Weird(int _num){
		num=_num;
	}
	
	void draw(){
		
	};
	
	
}
