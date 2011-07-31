import processing.opengl.*;

Houba h;

void setup(){
	size(200,200,OPENGL);
	background(255);
	h = new Houba();
}


void draw(){
	background(255);
	h.run();
	
}

//// houba //////////////////////////////// >

class Houba{
	int lg;
	float xe[],ye[];
	float theta;

	Houba(){
		lg = (int)random(50);
		xe = new float[lg];
		ye = new float[lg];
		theta = random(-PI,PI);
		
		float lastY = 0;
		
		for(int i = 0;i < lg;i++){
			xe[i] = width/2f;
			ye[i] = height/2f;
			
			xe[i] += random(-10,10);
			ye[i] += random(-10,10)+lastY;
			lastY = ye[i];
		}
		
	}
	
	//// run //////////////////////////////// >
	
	void run(){
		for(int i = 0;i < lg;i++){
		
		pushMatrix();
		
		rotate( theta );
		draw();
		popMatrix();
		}
		
	}
	
	//// compute //////////////////////////////// >
	
	void compute(){
		
		
		
	}
	
	void draw(){
		stroke(0);
		line(0,0,20,0);
		
		
	}
	
}



