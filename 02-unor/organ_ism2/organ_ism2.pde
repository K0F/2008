// organ_ism >> kof

import processing.opengl.*;

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
int num = 60;
Org[] org = new Org[num];
PImage shade;
//////////////////////////////////////////////////////////////////////

void setup(){
	size(1024,768,OPENGL);
	background(0);
	textFont(loadFont("ZapfHumanist601BTCE-Ultra-18.vlw"));
	noStroke();
	fill(255);

	frame.setTitle("gene_tics by KOF");

	shade = loadImage("shade.png");

	for(int i = 0;i<num;i++){
		org[i] = new Org(i);
	}
}

//////////////////////////////////////////////////////////////////////

void draw(){
	background(0);

	for(int i = 0;i<num;i++){
		org[i].run();
          fill(org[i].C,5);
for(int r = 0;r<org[i].len;r++){
  
                text(org[i].dna.charAt(r),3+(r*8),20);
}
	}
}

//////////////////////////////////////////////////////////////////////

void mousePressed(){
	if(mouseButton==LEFT){
		for(int i = 0;i<num;i++){
			if(dist(org[i].x,org[i].y,mouseX,mouseY)<50){
				org[i].grow();
				org[i].mutate();
			}
		}
	}else{
		for(int i = 0;i<num;i++){
			org[i] = new Org(i);
		}

	}

}

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////

class Org{
	float tx,ty,x,y;
	float move = 10f;
	float tol = 80f;
	int probab = 100; //5000 ku 5
	int last = 0;
	String dna = "@";
	int len;
	int degen;
	int id;
	float theta[];
	float speed = 100f;
	int contact = 0;
	color C;

	Org(int _id){
		id = _id;
		C = color(random(20,255), random(20,255), random(20,255));
		degen = (int)random(1,3);
		len = (int)random(3,33);
		theta = new float[len];
		dna = generate(len);

		x=tx=random(width);
		y=ty=random(height);
	}

	//////////////////////////////////////////////////////////////////////

	void run(){
		nodes();
		draw();
	}

	//////////////////////////////////////////////////////////////////////

	boolean bordrs(int brdr){
		boolean contact = false;
		float offset = len*2.0f;

		if(x<brdr) {tx=width/2f+offset;contact = true;}
		if(y<brdr) {ty=height/2f+offset;contact = true;}
		if(x>width-brdr){ tx=width/2f-offset;contact = true;}
		if(y>height-brdr){ ty=height/2f-offset;contact = true;}

		if(contact){
			//mutate();
		}

		return contact;
	}

	//////////////////////////////////////////////////////////////////////

	void nodes(){
		String nula = "0";
		if(!bordrs(20)){

			for(int i = 0;i<dna.length();i++){

				if(nula.equals(dna.charAt(i)+"")){
					theta[i]+=((radians(73f))-theta[i])/speed;

					if(nula.equals (dna.charAt(constrain(i+1,0,len-1))+"")){
						tx+=((tx-move)-tx)/speed;
					}else{
						tx+=((tx+move)-tx)/speed;
					}

				}else{

					if(!nula.equals (dna.charAt(constrain(i+1,0,len-1))+"")){
						ty+=((ty-move)-ty)/speed;
					}else{
						ty+=((ty+move)-ty)/speed;
					}

					theta[i]+=((radians(-51f))-theta[i])/speed;;

				}

			}



		}
		x+=(tx-x)/speed;
		y+=(ty-y)/speed;


		pushMatrix();
		translate(x-5,y-5);
		for(int i = 0;i<dna.length();i++){

			rotate(theta[i]);

			if(last==i) {
				stroke(255,0,0,55);
			}else{
				stroke(C,55);
			}
			noFill();
			line(0,0,(100*i)/(len+1f),0);
			rect((100*i)/(len+1f),0,4,4);


		}
		popMatrix();

	}

	//////////////////////////////////////////////////////////////////////

	void draw(){
		if(copulate()==0){
			for(int i = 0;i<len;i++){
				if(i!=last){
					fill(C,40);
				}else{
					fill(255,0,0,40);
				}
				//text(dna.charAt(i),x+(i*8),y);
			}
		}else if(copulate()==1){
			for(int i = 0;i<len;i++){
				if(i!=last){
					fill(org[contact].C,50);

				}else{
					stroke(255,0,0,80);
					line(x+(i*8)+4,y-4,org[contact].x+(i*8),org[contact].y-4);
					fill(255,255,255,140);
				}
				//text(dna.charAt(i),x+(i*8),y);
			}
		}else if(copulate()==2){
			for(int i = 0;i<len;i++){

				fill(C,60);

				stroke(C,55);
				line(x+(i*8)+4,y-4,org[contact].x+(i*8)+4,org[contact].y-4);
				//text(dna.charAt(i),x+(i*8),y);
			}
		}

		/*tint(C,25);
		image(shade,x-shade.width*.5,y-shade.height*.5);
		noTint();*/
		fill(C,155);
		text(len,x+10,y-10);
	}

	//////////////////////////////////////////////////////////////////////

	String generate(int len){
		String answ = "";

		for(int i =0;i< len;i++){
			if(random(50)>25){
				answ+="0";
			}else{
				answ+="1";
			}
		}

		return answ;
	}

	//////////////////////////////////////////////////////////////////////

	void mutate(){
		String answ[];
		String answr = "";
		int q = (int)random(dna.length());
		last = q;
		answ = new String[dna.length()];

		for(int i = 0;i<dna.length();i++){
			if(i!=q){
				answ[i] = ""+(dna.charAt(i));
			}else{
				answ[i]=inv(""+(dna.charAt(i)));
			}
			answr+=answ[i];
		}
		dna=answr+"";
	}

	//////////////////////////////////////////////////////////////////////

	void grow(){
		if(random(50)<25){
			dna+="0";
		}else{
			dna+="1";
		}
		len = dna.length();
		theta = new float[len];
	}

	void fall(){
		if(len>1){
			String tmp = "";
			for(int i = 0;i<len-1;i++){
				tmp+=""+dna.charAt(i);
			}
			dna = tmp+"";
			len = dna.length();
		}
	}

	int copulate(){
		int action = 0;

		for(int which = 0;which<org.length;which++){
			float dista = dist(x,y,org[which].x,org[which].y);
			if((dista < tol)){
				if(org[which].len>len){

					if(!maCompleteGen(which)){
						action=1;
						contact = which;
						String tmp[] = new String[len];
						String _dna = "";
						for(int i = 0;i<len;i++){
							if(random(probab)<5){
								tmp[i] = ""+ org[which].dna.charAt(i)+ "";
								last=i;
							}else{
								tmp[i] = dna.charAt(i)+"";
							}

							_dna += tmp[i];
						}
						dna = _dna;
					}else if(maCompleteGen(which)){
						C = org[which].C;
						action = 2;
						contact = which;
					}
				}
			}
		}
		return action;
	}

	//////////////////////////////////////////////////////////////////////

	boolean maCompleteGen(int partner){
		boolean answr = true;
		String partnerDna = org[partner].dna;

		for(int i = 0;i<len;i++){
			String tmp = partnerDna.charAt(i)+"";
			if(!tmp.equals(dna.charAt(i)+"")){
				answr = false;
				break;
			}
		}
		return answr;
	}

	String inv(String src){
		String answ = "1";
		if(src.equals("1")){
			answ = "0";
		}
		return answ;
	}

}

//////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////
