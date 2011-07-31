
import processing.opengl.*;


int num = 50;
Modular[] modular = new Modular[10];

void setup(){
	size(600,300,OPENGL);
	background(0);
	frame.setTitle("modular >> by kof");
	
	modular = new Modular[num];

	for(int i =0;i<num;i++){
		modular[i] = new Modular(-(int)random(500),(int)random(500),(int)random(12,50));

	}

	stroke(255,25);
	noFill();
	rectMode(CENTER);
	
	textFont(loadFont("ArialMT-9.vlw"));

	smooth();
}

void draw(){
	background(0);
	for(int i =0;i<num;i++){
		modular[i].run();
	}
}

class Modular{
	int code[];
	float thetas[];
	float speed = 50.0f;
	float r [];
	float u = 10;
	float soucet = 0,prum;

	float x,y;

	int len;

	Modular(int mn,int mx,int _len){
		len=_len;

		speed = abs(mn-mx)*len;

		code = new int[len];
		thetas = new float[len];
		r =new float[len];
		x=random(15,width-15);
		y=height/2;

		for(int q=0;q<len;q++){
			code[q] = (int)random(mn,mx);
			r[q] = random(5,50);
		}
	}

	void run(){
		compute();
		draw();
	}

	void compute(){
		soucet = 0.0f;

		for(int q=0;q<len;q++){
			thetas[q] += code[q]/speed;
			soucet+=thetas[q];
		}
		prum = soucet/len;

		y = sin(prum)*80+height/2;


	}

	void draw(){
		for(int q=0;q<len;q++){
			pushMatrix();
			translate(x,y);
			pushMatrix();
			rotate(thetas[q]);
			line(0,0,r[q],0);
			rect((r[q]+u/2.0f),0,u,u);
			/*fill(255);
			text(code[q],r+q/2,0);
			noFill();*/
			popMatrix();
			popMatrix();
		}
		line(x,y,x,height);
	}
}
