class Vale{
	float x,y;
	float ex,ey,ex2,ey2;
	float cnt = 0;
	float speed;
	float prirustek;
	color c;
	float br;
	
	Vale(){
		reset();
		c=(0);
		
		if(random(50)>25){
		c=(#CCFFFFFF);//(int)random(0,255);
		}else{
		c=(#FF110000);	
		}
		
		br=random(1.1f,8);
	}

	void draw(){
		compute();
		cnt+=prirustek;
		stroke(c,15);
		line(ex,ey,x,y);
		line(ex,ey,ex2,ey2);
	}

	void reset(){
		cnt=(int)random(500);
		y = random(0,height);
		x = random(0,width);
		softReset();
	}
	
	void softReset(){
		speed = random(10,150);
		prirustek = random(-3,3);
	}
	
	void compute(){
		ex2=ex+cos(cnt/100.f)*(cnt%13.0f);  
		ey2=ey+sin(cnt/100.f)*(cnt%13.0f);
		
		ex+=(ex2-ex)/((sin(cnt/100.0f)*10.0f));
		ey+=(ey2-ey)/((cos(cnt/100.0f)*10.0f));
		
		ex=x+sin(cnt/speed)*(cnt%13.0f);
		ey=y+cos(cnt/speed)*(cnt%13.0f);
		
		x+=(ex-x)/br;
		y+=(ey-y)/br;
		
		bounds(width/2);
	}
	
	void bounds(int b){
		if(x>width+b||x<-b||y>height+b||y<-b){
			reset();
		}
		
	}

}
