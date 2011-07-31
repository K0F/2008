import processing.opengl.*;


int num = 50;
PImage cross;
Cross[] c;
int w,h;

void setup(){
	size(200,400,OPENGL);
	background(255);

	cross = loadImage("cross2.png");
	c = new Cross[num];

	
	for(int i = 0;i<num;i++){
		
		c[i]=new Cross(i);
	}
	
	w = cross.width;
	h = cross.height;
	
	//noSmooth();
}

void draw(){
	background(0);
	
	
	for(int i = 0;i<num;i++){
		//lina(i);
		c[i].run();
	}

}

void lina(int i){
	int q;
	q = constrain(i+1,0,num-1);
	stroke(c[i].c,15);
	line(c[i].x+w/2,c[i].y+h/2,c[q].x+w/2,c[q].y+h/2);
	
}

class Cross{
	float x,y;
	float theta = 0,speed;
	int id;
	color c;

	Cross(int  _id){
		id = _id;
		x = random(-15,width+15);
		y = random(-15,height+15);
		c=((int)random(255));
		speed = random(-0.51f,0.51f);
	}

	void run(){
		compute();
		draw();


	}
	
	void compute(){
		theta += speed/2.0;
		
		x=width/2.0f+(width*0.5f*(sin(theta/10.0f)))-w/2.0f;
		
		
	}

	void draw(){
		pushMatrix();
		translate(x,y);
		pushMatrix();
		translate(cross.width/2.0f,cross.height/2.0f);
		rotate(theta);
		tint(c,200);
		image(cross,-cross.width/2.0f,-cross.height/2.0f,cross.width/1.0f,cross.height/1.0f);
		popMatrix();		
		popMatrix();



	}




}



