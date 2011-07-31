class Organ{
	float x,y;
	float tx,ty;
	PImage illus;
	int type;
	int numOfTypes = 3;
	int id,parID;
	String dna;
	float speed = 60.0;
	int roz = 200;

	Organ(String _dna,int _parID,int _id){
		dna=_dna;
		parID=_parID;
		id=_id;
		if(dna.charAt(id)=='0'){
			type = 0;
		}else{
			type = 1;
		}

		String which = type+"";
		illus = loadImage(type+".png");

		////////////////////////////////////

		x=tx=random(width);
		y=ty=random(height);
	}

	void run(){
		comp();
		draw();
	}

	void comp(){
		if(type==1){
		tx+=(width*0.5*(cos(o[parID].X/speed)+1)-tx)/speed;
		ty+=(height*0.5*(sin(o[parID].Y/speed)+1)-ty)/speed;
		}else{
		tx+=(width*0.5*(sin(o[parID].X/speed)+1)-tx)/speed;
		ty+=(height*0.5*(cos(o[parID].Y/speed)+1)-ty)/speed;
		}
		x += (tx-x) / speed;
		y += (ty-y) / speed;
		
	}

	void draw(){
		tint(255,50);		
		image(illus,x-illus.width/2.0,y-illus.height/2.0);
		/*text(id+";"+type,x,y);
		fill(0,85);*/
	}


}
