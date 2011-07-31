int c = 155;
Shit s;
void setup(){
	size(200,200);
	frame.setTitle("shaiat dman");
	frame.setLocation(0,0);
	s = new Shit();
	frameRate(30);
	println(s.q+"goo!");

}

void draw(){
	if(frameCount%5==0){
		background(c);
	}else{
		background(0);
	}
}

class Shit{
	int q = 0;
	Shit(){
		q=5;
	}

}



