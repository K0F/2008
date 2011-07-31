Recorder rec;

PImage frame;
color a;
void setup(){
	size(720,576,P3D);
	background(a);
	colorMode(HSB,255);
	frameRate(10);
	noStroke();
	smooth();
	a = color(#FFFFFF);
	rec = new Recorder("out","davidColors6.avi");
	frame = loadImage("frame.png");
}

void draw(){
	if(frameCount%2==0)a = color(random(255),random(255),random(25));
	//a = color(hue(a)+1,saturation(a)+1,brightness(a)+1);
	background(a);

	a = invert(a);

	tint(0);
	image(frame,random(-6,0),random(-6,0),width+6,height+6);
	filter(BLUR,3);

	fill(a);
	pushMatrix();
	translate(width/2,height/2);
	pushMatrix();
	point(0,0);
	rotate(sin(frameCount/300.0)*3002.13);
	triangle(0,-70,60,35,-60,35);
	popMatrix();
	popMatrix();
	filter(BLUR,1.8);

	rec.add();
}


void keyPressed(){

	if(key=='q'){
		rec.finish();
		exit();
	}
}


color invert(color A){
	color B;
	float SAT,HUE,LIGH;
	SAT = 255-saturation(A);
	HUE = 255-hue(A);
	LIGH = 255-brightness(A);
	B = color(HUE,SAT,LIGH);
	return B;

}

