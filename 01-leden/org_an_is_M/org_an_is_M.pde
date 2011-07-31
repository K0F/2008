/**
*ORGANISM @_org_an_is_M is a project by kof
*
*
*
*/

import processing.opengl.*;

Organism o[];

void setup(){
	size(800,600,OPENGL);
	frame.setTitle("\\@ org_an_is_m @/");

	background(233);
	textFont(loadFont("AlternateGothicNo2BTCE-Regular-18.vlw"));
	fill(0);
	noStroke();
	o = new Organism[40];

	for(int i =0;i<o.length;i++){
		o[i] = new Organism(i);

	}

}

void draw(){
	background(233);
	for(int i =0;i<o.length;i++){
		for(int q =0;q<o.length;q++){
			if(q!=i){
			strokeWeight(3);
			stroke(255,43,43,25);
			line(o[i].X,o[i].Y,o[q].X,o[q].Y);
			strokeWeight(1);
			}
		}
		o[i].run();
	}
}

class Organism{
	Organ organs[];
	int num = 1;
	String dna = "010000000111";
	float X,Y;
	int id;
	
	Organism(int _id){
		id=_id;
		num = dna.length();

		organs = new Organ[num];

		X = width/2.0;
		Y = height/2.0;

		for(int i = 0; i<num;i++){
			mutace();
			organs[i] = new Organ(dna,id,i);
			X += (random(width)-X)/2.0;
			Y += (random(height)-Y)/2.0;
		}

	}

	void run(){
		comp();
		draw();
	}

	void comp(){
		for(int i = 0; i<num;i++){
			organs[i].run();
			X += (organs[i].x-X)/2.0;
			Y += (organs[i].y-Y)/2.0;
		}


	}

	void draw(){
		for(int i = 0; i<num;i++){
			stroke(0,55*norm(dist(organs[i].x,organs[i].y,X,Y), width,0));
			//line(organs[i].x,organs[i].y,X,Y);

		}
		//text(dna,(int)X,(int)Y);

	}

	void mutace(){
		String tmp = "";
		for(int i = 0;i<dna.length();i++){
			if(random(50)<25.0){
				tmp += change(dna.charAt(i));
			}else{
				tmp += dna.charAt(i);
			}
		}
		dna=tmp+"";
	}

	char change(char _q){
		char a='0';
		if(_q=='0'){
			a='1';
		}
		return a;
	}



}

