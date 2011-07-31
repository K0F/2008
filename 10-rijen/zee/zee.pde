Q q;
int ID = 0;

void setup(){
	size(1600,900,P3D);
	background(0);
	q = new Q(600);
	smooth();
	textFont(createFont("Tahoma",100));
	textMode(SCREEN);
}

void draw(){
	//background(0);
	q.run();
}

void keyPressed(){
	if(key==' '){
		saveFrame("out_####.png");
	}
	keyPressed=false;

}

class Q{

	float x[];
	float y[];
	color c[];
	float tx,ty;
	int num;
	float speed [];

	Q (int _num){
		
		num = _num;
		speed = new float[num];
		c = new color[num];
		x = new float[num];
		y = new float[num];

		tx = random(width);
		ty = random(height);

		for(int i =0;i<num;i++){
			x[i] = random(width);
			y[i] = random(height);
			speed[i] = random(10,800);
			c[i] = (color)(lerpColor(#ffffff,#ffcc00,random(1000)/1000.0));
		}
	}

	void run(){
		compute();
		draw();
	}

	void compute(){
		for(int i = 0;i < num;i++){
			x[i]+=(tx-x[i]+cos(y[i]/30.0)*100.0)/speed[i];
			y[i]+=(ty-y[i]+sin(x[i]/30.0)*100.0)/speed[i];
		}
		if(frameCount%800==0)
		reset();
	}
	
	void draw(){
		//stroke(255,0.05*(frameCount%300));
		for(int i= 0; i<num;i++){			
			stroke(c[i],constrain(map(dist(x[i],y[i],tx,ty),380.0,0.0,0.0,10.0),0.0,10.0));

			line(x[i]-3,y[i],x[i]+3,y[i]);
			line(x[i],y[i]-3,x[i],y[i]+3);
		}
	}

	void reset(){
		fill(0,230);
		text((char)(int)random(94,125)+"",tx-45,ty+45);
		
		for(int i =0;i<num;i++){
			x[i]=(random(width));
			y[i]=(random(height));
		}
		tx=random(width);
		ty=random(height);
	}

}
