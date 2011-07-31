PImage img;


int num = 5;
float x[],y[],tx[],ty[];
float speed = 0.01;
int trsh = 50;

void setup(){
	size(400,220,P3D);
	img = loadImage("pf.jpg");
	img.mask(img);

	x=new float[num];
	y=new float[num];
	tx=new float[num];
	ty=new float[num];
	
	println("done");

}



void draw(){
	
	
	for(int i =0;i<num;i++){
		x[i]+=(tx[i]-x[i])*speed;
		y[i]+=(ty[i]-y[i])*speed;
		tint(random(255),random(255));
		image(img,x[i],y[i]);
	}
	

	if(frameCount%trsh==0){
		move();
	}

}

void move(){
	for(int i =0;i<num;i++){
		tx[i] = random(-img.width+width,0);
		ty[i] = random(-img.height+height,0);
	}
}
