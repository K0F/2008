import processing.serial.*;

Motor m;

///////////////
float CC = 7.0;
/////////////// second per run

int easing = 121;
/////////////////// 0 ... 127 - kompenzace hmotnosti
// 101 .. vidlicka

boolean sinoid = false;
boolean ready = true;
int time = 0;

void setup(){
 size(256, 150);
 frameRate(50);
 m = new Motor(this);
 //m.port.write(64);
 
 noStroke();
 textFont(createFont("Anorexia",9));
 
}

void draw(){
 background(0);
 fill(255,155);
 rect(10,10,15,height-20);
 rect(10,map(m.amount,0,255,height-10,10),15,3);
 text("<"+m.amount,30,map(m.amount,0,255,height-10,10)+3);
 
 
 rect(50,10,10,10);
 rect(65,10,10,10);
 
 if(m.direction==0){
 	rect(50,10,10,10);
 	text("<< L",37,32);
 }else{
 	rect(65,10,10,10);
 	text("R >>",65,32);
 }
 
 text("compens: "+easing,width-150,10);
 
 if(sinoid){
 	int cycle = 0;
 	if(m.direction==1){
 	cycle = (int)((sin(time/(50.0*CC))+1)*easing);
 	}else{
 	cycle = (int)((sin(time/(50.0*CC))+1)*127);
 	
 	}
 	m.am(cycle);
 	if(cycle>5&&!ready){
 		ready = true;
 	}
 	if(cycle<1&&ready){
 		ready = false;
 		if(m.direction==0){
 		m.R();
 		}else{
 		m.L();
 		}
 	}
 	 	time++; 

 }
 
}

void keyPressed(){
	if(keyCode == LEFT){
		m.L();
	}else if(keyCode == RIGHT ){
		m.R();
	
	}else if(keyCode == UP){
		m.amount++;
		m.amount=constrain(m.amount,0,255);
		m.am(m.amount);
	}else if(keyCode == DOWN){
		m.amount--;
		m.amount=constrain(m.amount,0,255);
		m.am(m.amount);
	}else if(key == 's'){
		sinoid = !sinoid;
		time = 0;
	}else if(key == 'w'){
		m.am(255);
	}else if(key == 'x'){
		m.am(0);
	}else if(key == 'q'){
		easing++;		
	}else if(key =='z'){
		easing--;
	}
	easing = constrain(easing,0,127);
	

}

void stop(){
	m.cool();
	super.stop();

}



class Motor{

 Serial port;

 int direction = 0;
 int amount = 128;
 
 Motor(PApplet parent){
  println("Available serial ports:");
  println(Serial.list());
  port = new Serial(parent, Serial.list()[0], 9600);
  cool();
  L();                          
  //port = new Serial(this, "COM1", 9600);
  
 }

 void L(){
	port.write("w d 5 1");
	port.write(13);
	port.write("w d 6 0");
	port.write(13);
	direction = 0;
 }
 
 
 void R(){
    port.write("w d 6 1");
    port.write(13);
    port.write("w d 5 0");
    port.write(13);
    direction = 1;
   }
   
   void am(int _am){
   	amount=_am;
   	String pre = amount+"";
   	port.write("w a 9 "+pre);
   	port.write(13);
   
   }
   
   void cool(){
   	am(0);
   }
                                                                                     



}
