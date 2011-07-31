PImage r;
float rot[],kot[];

void setup(){
	size(320,240);
	r=loadImage("r.png");
	background(0);
	smooth();
	noStroke();
	fill(0,15);
	
	int gi = 0;
	for(int x = 0;x<width;x+=r.width){
		for(int y = 0;y<width;y+=r.height){
			gi++;
		}
	}
	rot = new float[gi];
	kot = new float[gi];
	
	for(int i = 0;i<rot.length;i++){
		rot[i] = random(-PI,PI);
		kot[i] = random(-50,50)/1000.0f;
	}
}

void draw(){
	
	rect(0,0,width,height);
	//background(0);
	
	int gi = 0;
	for(int x = 0;x<width;x+=r.width){
		for(int y = 0;y<width;y+=r.height){
			rot[gi]+=kot[gi];
			displayImage(r,x,y,rot[gi],true);
			gi++;
		}
	}


}

void displayImage(PImage _img,float _x,float _y,float _rot,boolean corn){
	
	
	pushMatrix();
	if(corn){
		translate(_x,_y);
	}else{
		translate(_x-_img.width/2,_y-_img.height/2);
	}
	pushMatrix();
	translate(_img.width/2,_img.height/2);
	rotate(_rot);
	image(_img,-_img.width/2,-_img.height/2);
	popMatrix();
	popMatrix();

}
