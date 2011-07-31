class One{
	Pice[] p;

	boolean first = true;
	int id;
	int num;
	float x,y,vx,vy;
	float veli = 50;
	float rych,roto;
	color cc;


	One(int _num,int _id){
		num=_num;
		id=_id;

		vx=x= random(width);
		vy=y= random(height);

		rych = random(-100,100)/1000.0;
		roto = random(0,50);
		cc = color(random(200,255),random(200,255),random(200,255));
	}

	void cast(){
		p = new Pice[num];
		for(int x =0;x<num;x++){
			
				p[x] = new Pice(
				                     random(-veli,veli),
				                     random(-veli,veli),
				                     x,id,
				                     cc);
			}
		

	}

	void live(){
		if(first){
			cast();
			first = false;
		}
		
		for(int i = 0;i<p.length;i++){
			if(p[i].time>p[i].initial){
			x+=(p[i].x-x)/(2.0);//vx+(cos(frameCount*rych)*roto);
			 y+=(p[i].y-y)/(2.0);//vy+(sin(frameCount*rych)*roto);
			}
		}                                                                           

		for(int i = 0;i<p.length;i++){
			p[i].live();
		}
		
		noFill();
		stroke(cc,100);
		ellipse(x,y,num*10.0,num*10.0);
		
		popiska();
		
		//bordr(50);
	}
	
	void bordr (int kolik){
		if(x>width-kolik)x=width-kolik;
		if(x<kolik)x=kolik;
		if(y>height-kolik)y=height-kolik;
		if(y<kolik)y=kolik;
		
	}
	
	void popiska(){
		stroke(cc,15);
		fill(0,200);
		line(x,y,x+20,y-20);
		line(x+20,y-20,x+50,y-20);
		rect(x+50,y-20,50,-10);
		fill(cc);
		text(">"+id+" : "+(num*num),x+50,y-20);
		noFill();
		
	}

}

class Pice{
	int id,parent;
	float ox,oy,x,y;
	color c = color(#ffcc00);
	int a = 150;
	int time =0;int initial;
	float speed = 50.0;
	float m,mm;

	Pice(float _ox,float _oy,int _id,int _parent,color _c){

		ox=_ox;
		oy=_oy;

		id=_id;
		c=_c;
		parent=_parent;
		initial = (int)random(40,200);

		//println(one[parent].x);
		x=one[parent].x;
		y=one[parent].y;

		m=random(-100,100)/500.0;
		mm=random(50);



	}

	void live(){
		time++;
		draw();


	}

	void draw(){
		noStroke();
		fill(c,a);

		if(time>initial){
			float X = X();
			float Y = Y();
			stroke(c,a/4.0);
			
			line(one[parent].x,one[parent].y,X,Y);
			noStroke();
			rect(X,Y,2,2);
			
			for(int i =0;i<10;i+=2){
				fill(c,(i)+(sin(frameCount*m)+2)*15);
				rect(X-(10-i)/2.0,Y-(10-i)/2.0,(10-i),(10-i));
				
			}

		}
		
		bordr(50);

	}
	
	void bordr (int kolik){
		if(x>width-kolik)x=width-kolik;
		if(x<kolik)x=kolik;
		if(y>height-kolik)y=height-kolik;
		if(y<kolik)y=kolik;
		
	}


	float X(){
		x+=((one[parent].x+ox)-x)/speed;
		return (x+cos(frameCount*m)*mm);
	}

	float Y(){
		y+=((one[parent].y+oy)-y)/speed;
		return (y+sin(frameCount*m)*mm);
	}


}
