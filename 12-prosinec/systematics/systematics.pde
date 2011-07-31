int pocet = 4;
Recorder r;
One one [];


boolean rec = false;



void setup(){
	size(720,576,P3D);

	one = new One[pocet];
	for(int i =0;i<pocet;i++){
		one[i] = new One((int)random(2,8),i);
	}
                  
	
	
	textFont(createFont("Veranda",9));
	textMode(SCREEN);
	
	if(rec){
		r= new Recorder("out","nano.avi");
		smooth();
	}
	
	background(0);
}



void draw(){
	//background(0);
	//println(frameCount);
	
	fill(0,50);
	rect(0,0,width,height);
	
	for(int i =0;i<pocet;i++){   
		one[i].live();
	}

	
	
	if(rec)
		r.add();
}                                                                                                        

void keyPressed(){
	if(key == 'q'){
		if(rec)
			r.finish();
		exit();
	}

}
