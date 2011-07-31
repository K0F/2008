class One{
	Pice[] p;

	boolean first = true;
	int id;
	int num;
	float x,y,vx,vy;
	float veli = 10.0;

	float brdr = 10.0;
	float rych,roto;
	color cc;
	float activity = 1.0;
	boolean hyperActivity = false;
	float r;

	boolean show = false;

	int ohon = 200;
	float xes[] = new float [ohon];
	float yes[] = new float [ohon];
	int runnr = 0;

	One(int _num,int _id){
		num=_num;
		id=_id;

		vx=x= width/2.0;//random(width);
		vy=y= height/2.0;//random(height);

		rych = random(-100,100)/500.0;
		roto = random(0,50);
		cc = color(random(100,255));
		r = num * 150.0;
	}

	void cast(){
		p = new Pice[num];

		for(int y =0;y<num;y++){
			p[y] = new Pice(
			               random(-veli,veli),
			               random(-veli,veli),
			               y,id,
			               cc);

		}

	}

	void live(){
		if(first){
			cast();
			first = false;
			
		}

		bordr(brdr);
		
		for(int i = 0;i<p.length;i++){
			if(p[i].time>p[i].initial){
				x+=(p[i].X()-x)/(num+0.000f);//vx+(cos(frameCount*rych)*roto);
				y+=(p[i].Y()-y)/(num+0.000f);//vy+(sin(frameCount*rych)*roto);
				x+=(width/2.0-x)/(width/2.0-dist(width/2.0,height/2.0,x,y));
				y+=(height/2.0-y)/(width/2.0-dist(width/2.0,height/2.0,x,y));
			}
		}

		

		for(int i = 0;i<p.length;i++){
			p[i].live();
		}
		

		if(hyperActivity){
			fill(255,100);
		}else{
			noFill();
		}
		stroke(cc,100);

		//if(show)
		//ellipse(x,y,r,r);
		//check();
		trasa();

		//if(show)
			//popiska();

		
	}

	void trasa(){
		xes[runnr] = x;
		yes[runnr] = y;

		runnr ++;
		runnr = runnr%xes.length;


		for(int i =1;i<xes.length;i++){
			if(i!=runnr){
				stroke(cc,map((i-runnr+ohon)%ohon,0,ohon*2,0,30));
				line(xes[i],yes[i],xes[i-1],yes[i-1]);
			}
		}
	}

	void check(){
		//activity = 0;
		for(int i =0;i<one.length;i++){

			if(dist(one[i].x,one[i].y,x,y)<(r/2.0)+(one[i].r/2.0)&&i!=id){
				syncTo(i,norm(dist(one[i].x,one[i].y,x,y),(r/2.0)+(one[i].r/2.0),0));
			}
		}



	}

	void syncTo(int who,float kolik){
		for(int i =0;i<p.length;i++){
			p[i].m = lerp(p[i].m,one[who].p[i].m,kolik);
			p[i].mm = lerp(p[i].m,one[who].p[i].m,kolik);
			p[i].ox = lerp(p[i].ox,one[who].p[i].ox,kolik);
			p[i].oy = lerp(p[i].oy,one[who].p[i].oy,kolik);
			p[i].time = (int)lerp(p[i].time,one[who].p[i].time,kolik);
		}

	}

	void bordr (float kolik){
		if(x>width-kolik)x=width-kolik-1;
		if(x<kolik)x=kolik+1;
		if(y>height-kolik)y=height-kolik-1;
		if(y<kolik)y=kolik+1;

	}

	void popiska(){
		stroke(cc,15);
		fill(0,200);
		line(x,y,x+20,y-20);
		line(x+20,y-20,x+50,y-20);
		rect(x+50,y-18,50,-12);
		fill(cc);
		text(" < "+id+" : "+(num*num),x+51,y-21);
		noFill();

	}

}

class Pice{
	int id,parent;
	float ox,oy,x,y;
	color c = color(#ffcc00);
	int a = 150;
	int time =0;int initial;
	float speed = 30.0;
	float m,mm;
	float mz;
	boolean hyper = false;
	
	int period;
	int durace;
	int nooise = 0;
	boolean noisePeriod=  false;

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

		mz=m=random(1001)/10000.0;
		mm=random(0,100);
		
		period = (int)random(200,2000);
		durace = (int)random(3,100);


	}


	void live(){
		time++;
		
		if(time%period==0){
			noisePeriod = true;
		}
		
		if(noisePeriod&&nooise<durace){
			nooise++;
		}else if(noisePeriod){
			nooise=0;
			noisePeriod = false;
		}
		
		
		draw();


	}


	void draw(){
		noStroke();
		fill(c,a);

		if(time>initial){
			if(viz){
				float X,Y;
				
				if(noisePeriod){
				one[parent].x=one[parent].x+random(-5,5);
				one[parent].y=one[parent].y+random(-5,5);
				X=X();
				Y=Y();
				fill(#FFCC00,150);
				stroke(#FFCC00,150);
				}else{
				X=X();
				Y=Y();
					fill(c,100);
					stroke(c,a/4.0);
				}
				line(X,Y,lerp(X,one[parent].x,0.5),lerp(Y,one[parent].y,0.5));
				noStroke();
				rect(one[parent].x-1,one[parent].y-1,2,2);
			}else{
				float a=X()+Y();
			}
		}else{
			x=one[parent].x;
			y=one[parent].y;
		}

	}


	float X(){
			x+=(((one[parent].x+ox)+cos(time*m)*mm)-x)/(speed);
	
		return (x);
	}

	float Y(){
		
			y+=(((one[parent].y+oy)+sin(time*m)*mm)-y)/(speed);
		
		return (y);
	}


}
