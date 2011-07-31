//import processing.opengl.*;


int pocet = 8;
Recorder r;
One one [];
OSC osc;


boolean rec = false;
boolean bluring = false;
boolean viz = true;

float [] storex,storey;


void setup(){
	size(720,576,P3D);

	
	storex = new float[pocet];
	storey = new float[pocet];
	one = new One[pocet];
	for(int i =0;i<pocet;i++){
		one[i] = new One(3,i);
	}
	
	osc = new OSC("127.0.0.1",12000);
                  
	//strokeWeight(3);
	                                                                 
	//textFont(createFont("Veranda",9));
	//textMode(SCREEN);
	
	//smooth();
	
	if(rec){
		r= new Recorder("out","nano2.avi");
	//	smooth();
	}
	
	background(0);
}



void draw(){
	//background(0);
	//println(frameCount);
	if(bluring)
	filter(BLUR,2);
	fill(0,2);
	rect(0,0,width,height);
	
	for(int i =0;i<pocet;i++){   
		one[i].live();
		osc.send(i,one[i].x,one[i].y,(dist(one[i].x,one[i].y,storex[i],storey[i])*10.0));
		storex[i] = one[i].x;
		storey[i] = one[i].y;
	}

	
	
	if(rec)
		r.add();
}

void stop(){
	for(int i =0;i<pocet;i++){   
	osc.send(i,0,0,0);
	}
}

void keyPressed(){
	if(key == 'q'){
		if(rec)
			r.finish();
		exit();
	}

}
