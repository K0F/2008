Being b;

void setup(){
	size(400,400);
	b=new Being(width/2,height/2);
	strokeCap(ROUND);
	background(255);
	smooth();
}

void draw(){
	background(0);
	b.run();
}

void mouseReleased(){
	b.unlock();
}



//// class which holds all functions for each class ////////////////// >>
public class Base{
	PImage illus;
	float x,y;
	float tx,ty;
	String fn;
	float speed = 500.0f;
	float dista;
	int c = 255;
	boolean locked = false;

	Base(float _x,float _y,String _fn){ ///***
		tx=x=_x;
		ty=y=_y;
		fn=_fn+"";
		illus=loadImage(fn);
	}

	void run(){
		compute();
		draw();
	}

	void draw(){
		pushMatrix();
		translate(-illus.width/8,-illus.height/8);
		tint(c,185);
		image(illus,x,y,illus.width/4,illus.height/4);
		popMatrix();
	}
	void compute(){

		if(mousePressed&&over()){
			locked = true;
		}



		if(locked){
			lock();
		}

		dista = dist(x,y,mouseX,mouseY);
		dista = constrain(dista,1,width*1.414f);

		x+=(tx-x)/speed;
		y+=(ty-y)/speed;

		bounds((int)(0.5*(illus.width/4+illus.height/4)));
	}

	boolean over(){
		boolean a = false;

		if(dista<40.0){
			a = true;
		}

		return a;
	}

	void lock(){
		tx=mouseX;
		ty=mouseY;
	}

	void bounds(int b){
		if(x<b) x=width-b;
		if(x>width-b) x=b;
		if(y<b) y=height-b;
		if(y>height-b) y=b;
	}
	
	void unlock(){
		locked=false;
	}

}


//// crowd of classes which extends the base ////////////////// >>
class Being extends Base{
	Q q;
	One one;
	Two two;
	Three three;
	Four four;
	E e;

	Being(float _x,float _y){
		super(_x,_y,"base.png"); //*** must be called first
		x=_x;
		y=_y;
		q = new Q(x,y);
		one = new One(x,y);
		two = new Two(x,y);
		three = new Three(x,y);
		four = new Four(x,y);
		e=new E(x,y);
	}

	void run(){
		noFill();
		stroke(255,127);
		strokeWeight(40.0f);

		line(q.x,q.y,one.x,one.y);
		line(one.x,one.y,two.x,two.y);
		line(two.x,two.y,three.x,three.y);
		line(three.x,three.y,four.x,four.y);
		line(four.x,four.y,e.x,e.y);

		q.run();
		one.run();
		two.run();
		three.run();
		four.run();
		e.run();
	}
	
	void unlock(){
		q.unlock();
		one.unlock();
		two.unlock();
		three.unlock();
		four.unlock();
		e.unlock();
	}
	
	

}

//// Q extends Base, in constructor calling "super" inits extending class ////////////////// >>
class Q extends Base{


	Q(float _x,float _y){
		super(_x,_y,"happy.png");
		x=_x;
		y=_y;
		x+=random(-width,width);
		y+=random(-50,50);
	}


}

class E extends Base{


	E(float _x,float _y){
		super(_x,_y,"sad.png");
		x=_x;
		y=_y;
		x+=random(-width,width);
		y+=random(-height,height);
	}


}

class One extends Base{

	One(float _x,float _y){
		super(_x,_y,"1.png");
		x=_x;
		y=_y;
		x+=random(-width,width);
		y+=random(-height,height);
	}

}

class Two extends Base{

	Two(float _x,float _y){
		super(_x,_y,"2.png");
		x=_x;
		y=_y;
		x+=random(-width,width);
		y+=random(-height,height);
	}

}

class Three extends Base{

	Three(float _x,float _y){
		super(_x,_y,"3.png");
		x=_x;
		y=_y;
		x+=random(-width,width);
		y+=random(-height,height);
	}
}

class Four extends Base{

	Four(float _x,float _y){
		super(_x,_y,"4.png");
		x=_x;
		y=_y;
		x+=random(-width,width);
		y+=random(-height,height);
	}

}






