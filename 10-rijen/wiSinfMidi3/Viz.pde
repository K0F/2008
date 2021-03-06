class Viz{
	float x,y,tx,ty;
	color c;
	float speed;
	String content = "";
	int time = 0,life;
	Viz(String a){
		x=width/2.0;//random(width);
		y=random(width);//random(height);
		tx=random(100,width-100);
		ty=random(10,height-10);//map(a.length(),0,300,50,height-50);
		c = (color)(lerpColor(#ffcc00,#aaaaaa,random(1000)/1000.0));
		content = a+"";
		life = (int)(content.length()/4.0);
		speed = life/10000.0;

	}

	void compute(){
		time++;
		x+=(tx-x)*speed;
		y+=(ty-y)*speed;


	}

	void draw(){
		if(time<life){
		compute();
		fill(c,map(time,0,life,255,0));
		rect(x,y-10,4,4);
		if(showPackets)
		text(content,x,y);
		noFill();
		stroke(c,map(time,0,life,255,0));		
		ellipse(x,y-10,life,life);
		}

	}


}
