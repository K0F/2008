import promidi.*;
import processing.opengl.*;

int num = 16;
int shift = 20;
String ver = "0.1";

MidiIO midiIO;
MidiOut midiOut;

PFont font;
Knob knob[];
Keyboard keyboard;

float y = 125;

void setup(){
	size( 500, 150 ,OPENGL);
	frameRate( 60 );

	midiIO = MidiIO.getInstance(this);
	midiIO.printDevices();
	midiOut = midiIO.getMidiOut(1,2);

	//-----------------------* frame icon
	String path = sketchPath("data/icon.gif");
	path.replace('\\','/');
	Image img = getToolkit().getImage(path);
	frame.setIconImage(img);
	frame.setAlwaysOnTop(true);
	frame.setTitle("knobMaster rev."+ver+" :: kof");

	knob = new Knob[num];
	keyboard = new Keyboard();

	for(int i = 0;i<num;i++){
		//c[i] = new Controller(i,0);
		knob[i] = new Knob((i*30)+20,y,i+shift);

	}

	font = loadFont("Uni0553-8.vlw");
	textFont(font);

        cursor(CROSS);

}

/*
void init(){
	frame.setUndecorated(true);
	super.init();
}*/


void draw(){
	background(#333333);
	for(int i = 0;i<num;i++){
		knob[i].run();
	}
	keyboard.run();
}


//// Knob class //////////////////////////////////////////////

class Knob{
	int value = 0;
	float speed = 1.5;
	float w=10,h=100;

	color Cback = color(255,55);
	color Cstroke = color(255);
	color Cactive = color(255,128,33);
	color Cmacroized = color(255,0,0,55);
	color Crecording = color(255,0,33);

	int target = value;
	int lastVal = value;

	float x,y;

	int id;
        int sec = 5; //sekund pameti
	int recordTime = 0,timer = 0;
	int[] vals = new int[sec*60];

	boolean someData = false;

	int mode = 0;
	Controller cont;

	Knob(float _x,float _y,int _id){
		id = _id;
		//cont = (Controller)_cont;
		x=_x;
		y=_y;
		//cont = new Controller(id,value);
	}

	void run(){

		if((someData)&&(!rec())){
			pushMatrix();
			translate(x,y);
			fill(Cactive,norm(timer,0,vals.length)*30+30);
			rect(w+3,-h,3,3);
			popMatrix();
			mode = 1;
			timer++;
			timer=timer%vals.length;
			target=vals[timer];
		}

		
		lastVal = value;
                
		if(mode == 0){
			fill(Cback);
			stroke(Cstroke);
		}else if(mode == 1){
			fill(Cmacroized);
			stroke(Cstroke);
		}
		rect(x,y,w,-h);

                value += (int)((target-value)/speed);
		if(!rec()){
			if (drag()||(mode==1)){
				fill(Cactive);
			}else{
				fill(Cback);
			}
		}else{
			fill(Crecording);
		}
		text(value,x+w+2,(int)map(value,0,127,y,y-h)+3);
		rect(x,map(value,0,127,y,y-h),w,3);

		fill(Cstroke);
		text(id,x,y-h-10);

		if(lastVal!=value){
			send();
		}



	}

	boolean rec(){
		boolean answr = false;

		if(over(10)&&(mousePressed)&&(mouseButton==RIGHT)){
			answr = true;
			someData = true;
			recordTime++;
			recordTime=recordTime%vals.length;
			target = (int)map(mouseY,y,y-h,0,127);
			target = constrain(target,0,127);
			vals[recordTime]=target;
		}

		return answr;
	}

	boolean drag(){
		boolean answr = false;


		if((over(10))&&(mousePressed)&&(mouseButton==LEFT)){

			answr = true;
			target = (int)map(mouseY,y,y-h,0,127);
			target = constrain(target,0,127);
			if(someData){
				recordTime = 0;
				timer = 0;
				mode = 0;
				someData = false;
				for(int i = 0;i<vals.length;i++){
					vals[i] = target;
				}
			}else{

				for(int i = 0;i<vals.length;i++){
					vals[i] = target;
				}
			}

		}


		return answr;
	}

	boolean over(int tol){
		boolean answr = false;
		if((mouseX>x-tol)&&(mouseX<x+w+tol)&&(mouseY<y+tol*2)&&(mouseY>y-h-tol*2)){
			answr = true;
		}
		return answr;
	}


	void send(){
		cont = new Controller(id,value);
		midiOut.sendController(cont);

	}
}

class Keyboard{
	float x,y;
	char[] keys = {
		'q','w','e','r','t','y','u','i','o',
		'a','s','d','f','g','h','j','k','l',
		'z','x','c','v','b','n','m',',','.'
	};
	float fades[] = new float[keys.length];
	Note notes[] = new Note[keys.length];

	Keyboard(){
		for(int i = 0;i<notes.length;i++){
			if(i<9){
				notes[i] = new Note((int)map(i%9,0,keys.length/3.0,20,110),100,50);
			}else if(i<18){
				notes[i] = new Note((int)map(i%9,0,keys.length/3.0,20,110),100,100);
			}else{
				notes[i] = new Note((int)map(i%9,0,keys.length/3.0,20,110),100,400);
			}
		}
	}

	void run(){
		
		
		
		if(keyPressed){
			
			for(int i = 0;i<keys.length;i++){
				if((char)key==keys[i]){
					send(i);
					fades[i] = 255;

				}
			}
		}
		
		
		for(int i = 0;i<keys.length;i++){
			fades[i] -= 5;
			fades[i] = constrain(fades[i],0,255);
			
			fill(knob[0].Cactive,fades[i]);
			rect((int)map(i,0,keys.length,5,width-5)+3,height-12,10,10);
			fill(knob[0].Cstroke);
			text(keys[i],(int)map(i,0,keys.length,5,width-5)+5,height-5);
		}

	}

	void send(int i){

		midiOut.sendNote(notes[i]);

	}


}
