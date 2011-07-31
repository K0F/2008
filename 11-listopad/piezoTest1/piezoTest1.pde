import processing.serial.*;

Piezo p;

void setup(){
	size(256, 150);
	frameRate(50);
	p = new Piezo(this);
	//m.port.write(64);

	noStroke();
	textFont(createFont("Anorexia",9));

}

void draw(){
	background(0);
	fill(255,155);
	if(p.tick)
	rect(10,10,15,height-20);

	//p.freq();
	
}

void keyPressed(){

}


class Piezo{

	Serial port;
	int pin1 = 9;
	int pin2 = 3;
	
	int cpin = 9;
	int freq = 200;
	
	boolean tick = false;

	int kadence;

	Piezo(PApplet parent){
		port = new Serial(parent, Serial.list()[0], 115200);


		port.write("w d "+12+" 1");
		port.write(13);
	}

	void bang(){
		if(tick){
			port.write("w d "+pin2+" 1");
			port.write(13);
			port.write("w d "+pin1+" 0");
		port.write(13);
			tick = !tick;
		}else{
			port.write("w d "+pin2+" 0");
			port.write(13);
			port.write("w d "+pin1+" 1");
		port.write(13);
			tick = !tick;
		}

	}
	
	void freq(){
		port.write("w a "+cpin+" "+freq);
		port.write(13);		
	}
	
	void freqUp(){
		freq++;
		freq=constrain(freq,0,255);
	}
	
	void freqDown(){
		freq--;
		freq=constrain(freq,0,255);
		
	}

	void cycle(int fr){
		if (frameCount%fr==0){
			bang();
		}
	}

}

