PShape p;


void setup(){
	size(300,300);
	p = loadShape("drawing.svg");
	smooth();

}

void draw(){
	background(120);
	shape(p,10,10);


}
