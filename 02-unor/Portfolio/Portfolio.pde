
String names[] = {"code","effort","god","open","rush","run","think","weird","quest"};
int num; 
Button b[];
PImage ico[];
PImage ram;

String ext = ".png";

void setup(){
	size(200,800);
	background(0);
		
	ram = loadImage("ram.png");
	num = names.length;
	b = new Button[num];
	ico = new PImage[num];
	
	for(int i = 0;i<num;i++){
		names[i] += ext;
		ico[i] = loadImage(names[i]);		
		b[i] = new Button(10,ico[i].height*i+10,ico[i]);
	}
	
	


}


void draw(){
	background(255);
	
	for(int i = 0;i<num;i++){
		b[i].run();
	}

}


class Button{
	PImage Icon;
	int x,y;
	int alph = 255;
	boolean Fdone = true;
	float xes = alph;

	Button(int _x,int _y,PImage _Icon){
		x=_x;
		y=_y;
		Icon = _Icon;

	}

	void run(){
		
		if(over()){
			fadeOff(15);
		}else if(!over()){
			fadeIn(8);
		}
		xes += ((alph/10.0)-xes)/15;
		
		noTint();
		image(Icon,x,y-xes);
		tint(255,255-alph);
		image(ram,x+xes,y);
	}
	
	
	
	void fadeOff(int speed){
		boolean faded = false;
		alph-=speed;
		if(alph<1){
			alph=0;
			faded = true;
			Fdone = true;
		}else{
			Fdone = false;
		}
			
	}
	
	void fadeIn(int speed){
		boolean faded = false;
		alph+=speed;
		if(alph>244){
			alph=255;
			faded = true;
			Fdone = true;
		}else{
			Fdone = false;
		}
			
	}

	boolean over(){
		boolean ans = false;
		if((mouseX>x)&&(mouseX<x+Icon.width)&&(mouseY>y)&&(mouseY<y+Icon.height)){
			ans = true;
		}
		return ans;
	}

	void mousePressed(){
		if(over()){
			action();
		}

	}

	void action(){


	}

}

