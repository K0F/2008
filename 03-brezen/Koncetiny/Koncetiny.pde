import processing.opengl.*;

Koncetina koncetina[];
int num = 30;


void setup(){
	size(1024,768,P3D);
	background(255);


	koncetina = new Koncetina[num];
	for(int i  = 0;i<koncetina.length;i++){
		koncetina[i] = new Koncetina(width/2-10,height/2,width/2+10,height/2,(int)random(30,50));
	}
	fill(0);
	textFont(createFont("Arial",9));
	cursor(CROSS);
	//smooth();
}


void draw(){
	background(255);
	for(int i  = 0;i<koncetina.length;i++){
		koncetina[i].run();
	}
}


class Koncetina{
	Part p[];
	int segs;
	float x1,y1,x2,y2,speed;
	boolean debug = false;
	color c;


	Koncetina(float _x1,float _y1,float _x2,float _y2,int _segs){
		x1=_x1;
		x2=_x2;
		y1=_y1;
		y2=_y2;
		segs=_segs;
		speed = random(1.2f,5.8f);
		c=(#ffccaaa0);

		p = new Part[segs];
		for(int i = 0;i<p.length;i++){
			p[i] = new Part( lerp(x1,x2,norm(i,0,p.length)),
			                 lerp(y1,y2,norm(i,0,p.length)),lerp(x1,x2,norm(i+1,0,p.length)),lerp(x1,x2,norm(i+1,0,p.length)),
			                 random(10f),i,lerpColor(0,#ffffcc00,norm(i+1,0,p.length+1)));
		}
	}

	void run(){
		compute();
		for(int i = 0;i<p.length;i++){
			p[i].draw();

			if(debug){
				text(i+"@ x1 :: y1",p[i].x1,p[i].y1);
				text(i+"@ x2 :: y2",p[i].x2,p[i].y2);
			}
		}
	}

	void compute(){


		p[0].x1=mouseX;
		p[0].y1=mouseY;

		p[0].x2+=(p[0].x1-p[0].x2) / speed;
		p[0].y2+=(p[0].y1-p[0].y2) / speed;

		for(int i = 1;i<p.length;i++){
			//p[i].x2+=p[i-1].x1
			p[i].x2+=(p[i].x1+p[i].oX-p[i].x2) / speed;
			p[i].y2+=(p[i].y1+p[i].oY-p[i].y2) / speed;

			p[i].x1+=(p[i-1].x2-p[i].x1) / 1.000001;
			p[i].y1+=(p[i-1].y2-p[i].y1) / 1.000001;
		}
	}

	void draw(){

	}

}

class Part{
	float x1,y1,x2,y2;
	int id;
	color c;

	float oX,oY;
	float sX,sY;
	float timer;
	float jump;
	float theta;

	Part(float _x1,float _y1,float _x2,float _y2,float _lim,int _id,color _c){
		c=_c;
		id=_id;
		x1=_x1;
		x2=_x2;
		y1=_y1;
		y2=_y2;

		timer = 0;
		jump = random(-_lim,_lim);

		sX = random(1.0f);
		sY = random(1.0f);
	}

	void draw(){
		compute();
		//strokeWeight(dist(x1,y1,x2,y2));
		stroke(0/*map(dist(x1,y1,x2,y2),0,200,200,0)*/,135);
		line(x1,y1,x2,y2);
	}

	void compute(){
		theta = atan2((y2-y1),(x2-x1));
		theta = map(theta,-PI,PI,0,1);
		
		jump+=((sin(frameCount/10.0f)*5.0f)-jump)/100.0f;
		sX=map(dist(x1,y1,x2,y2),0,20,20,0);
		sY=map(dist(x1,y1,x2,y2),0,20,20,0);
		timer+=jump;
		oX += (cos(timer/30.0f)*sX-oX)/10.0f;
		oY += (sin(timer/30.0f)*sY-oY)/10.0f;
		/*oX*=sX;
		oY*=sY;*/

	}
}
