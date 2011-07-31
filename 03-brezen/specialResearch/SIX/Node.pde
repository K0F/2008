class Node{
	float x,y;
	int id;
	int pocetUzlu = 3;
	float radi = 10f;
	float speed = 100f;

	Uzel[] u;

	Node(){
		x=random(width);
		y=random(height);
		radi = 3f;
		speed = 10f;
	}

	
	Node(int _id){
		id=_id;
		x=random(width);
		y=random(height);

		u = new Uzel[pocetUzlu];
		for(int i = 0;i<u.length;i++){
			u[i]=new Uzel(i,this);
		}
	}

		
	void run(){
		compute();
		draw();
	}
	
	void compute(){
		x+=(width/2f-x)/speed;
		y+=(height/2f-y)/speed;
	}

	void draw(){
		fill(255,35);
		noStroke();
		ellipse(x,y,radi*2,radi*2);
		drawLines();
	}
	
	void drawLines(){
		
		for(int i = 0;i<u.length;i++){
			stroke(255,45);
			line(x,y,u[i].x,u[i].y);
			noStroke();
			fill(255,45);
			u[i].run();
		}
	}

}

class Uzel extends Node{
	int id;
	Node parent;
	float tx,ty;

	Uzel(int _id,Node p){
		super();
		p = parent;
		id = _id;
		tx=random(super.x-100,super.x+100);
		tx=random(super.y-100,super.y+100);
	}
	
	
	void draw(){
		ellipse(x,y,radi*2,radi*2);
	}
	
	void compute(){
		x+=(tx-x)/speed;
		y+=(ty-y)/speed;
	}
	
		


}
