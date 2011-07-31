//import processing.opengl.*;

Linka l[];
int num = 100;
int ID = 0;

void setup(){
	size(300,200,P3D); background(0); stroke(255,55);
	
	l = new Linka[num];
	 for(int i =0;i<l.length;i++) l[i] = new Linka();
	
	textFont(createFont("Anorexia",9)); textMode(SCREEN);
}

int cc = 0;

void draw(){
	background(0);
	for(int i =0;i<l.length;i++) 
	l[i].draw();
}

class Linka{
	int id; float pri; float y; color c;
	
	Linka(){
		id=ID; ID++; y=random(0,height); pri = 
		(id-num)/100.0;//random(-100,100)/100.0; 
		c = color(random(127,255),random(127,255),random(127,255));
	}

	void bordr(){
		if(y>height)y=0; if(y<0)y=height;
	}

	void draw(){
		bordr();
		y+=pri;
		stroke(c,55);
		fill(c,155); 
		line(0,y,width,y); 
		//line(l[constrain(id-1,0,l.length)].id*2+10,l[constrain(id-1,0,l.length)].y,10+id*2,y); 
		text(id,10+id*2,y);

	}

}
