class Euron{
	String info;
	int id;
	int tata;
	int level;
	int len;
	int mutation;
	int val;
	float x,y;
	float r = 10;
	int life;
	float speed  =3.0;
	int tata_pahyl;

	Euron(int _len){
		level=LEVEL;
		id=ID;ID++;
		len = _len;

		x=width/2;y=height/2;
		info = "";
		for(int i = 0;i<len;i++){
			info += (char)((int)random(65,72));
		}
		val = hodnota();
		//println(id+"::"+val+"::"+info);

	}

	Euron(String in,int _mutation,int _pahyl,int _tata){
		level=LEVEL;
		id=ID;ID++;
		mutation = _mutation;
		tata = _tata;
		info = "";
		tata_pahyl = _pahyl;

		x = e[tata].x;
		y = e[tata].y;

		for(int i = 0;i<in.length();i++){
			if(random(100)<mutation){
				info += (char)((int)random(65,72));
			}else{
				info += in.charAt(i)+"";
			}
		}

		val = hodnota();

		//println(id+"::"+val+"::"+info);
	}

	void reprodukce(int pos,int muta){
		e=(Euron[])expand(e,e.length+1);
		e[e.length-1]=new Euron(info,muta,pos,id);
	}

	void born(int muta){
		for(int i =0;i<info.length();i++)
			reprodukce(i,muta);
	}

	void live(){
		life++;

		if(id!=0){
			x += (e[tata].x+cos(e[tata].valAt(tata_pahyl)*45)*(20.0)-x)/speed;
			y += (e[tata].y+sin(e[tata].valAt(tata_pahyl)*45)*(20.0)-y)/speed;
			//x += (e[tata].x-x)/(speed);
			//y += (e[tata].y-y)/(speed);

		}else{
			x+=(mouseX-x)/speed;
			y+=(mouseY-y)/speed;
		}

		draw();
	}

	void draw(){
		noFill();
		ellipse(x,y,r,r);
		fill(0,155);
		text(val,x,y-7);
		stroke(0,55);

		for(int i =0;i<info.length();i++){
			line(
			        x+cos(valAt(i)*45)*20.0,
			        y+sin(valAt(i)*45)*20.0,
			        x+cos(valAt(i)*45)*(r/2.0),
			        y+sin(valAt(i)*45)*(r/2.0));
		}

	}

	int hodnota(){
		int soucet = 0; for(int i =0;i<info.length();i++)
			soucet+=((int)info.charAt(i))-64; return soucet;
	}

	int valAt(int in){
		return (((int)info.charAt(in))-64);
	}
}

