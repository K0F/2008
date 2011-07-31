
Recorder r;

void setup(){
  size(320,240,P3D);    
	background(255);
	r = new Recorder("out","jpeg.mpg");
}

int i =0;

void draw(){
	i++;
	stroke(0,15);
	line(i,sin(i*0.01)*50.0,i,height);
	if(i>width)i=0;
	r.add();

}

void exit(){
	r.finish();
	super.exit();

}

