class Cube{
	float x,y;
	String a;
	float speed = 0.01;
	Popiska p[];
	
	Cube(){
		x=width/2.0;
		y=height/2.0;
		textFont(createFont("Veranda",9));
		textMode(SCREEN);
		
		p = new Popiska[100];
		for(int i = 0;i<p.length;i++){
			String temp = "";
			for(int q = 0;q<(int)random(5,14);q++){
				temp = ""+q;//(char)random(65,94);
			p[i] = new Popiska(temp,random(-50,50),random(-50,50),random(-50,50));
			}
		}
	}                                                          
	
	void draw(){
		pushMatrix();
		translate(x,y);
		pushMatrix();
		
	rotateY(frameCount*speed);
		noFill();
		stroke(0,200);
		box(100);
		for(int i = 0 ;i<p.length;i++)
			p[i].draw();
		popMatrix();
		popMatrix();
	}
	
}

class Popiska{
	float x,y,z;
	String s;
	
	Popiska(String content,float _x,float _y,float _z){
		x=_x;
		y=_y;
		z=_z;
		s = content+"";
	}
	
	void draw(){
		fill(0);
		stroke(0,100);
		line(x+10,y-10,z,x,y,z);
		line(x+10,y-10,z,x+100,y-10,z);
		text(s,(int)screenX(x+100,y-10,z),(int)screenY(x+100,y-10,z));
		
	}
}
