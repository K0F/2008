import processing.serial.*;

import oscP5.*;//import the OSC library
import netP5.*;


Serial port;
String data;
String serialString;
String[] vals = new String[3];


boolean listen = true;
int sel = 1;
float posX[],posY[],posZ[];

OSC osc;

Cube cub;


void setup(){
	size(1000, 600,P3D);
	frameRate(25);
	data = "";
	textFont(createFont("Veranda",9));
	textMode(SCREEN);

	fill(255);
	stroke(0,100);

	cub = new Cube();
	noCursor();
	smooth();
	
	
	posX= new float[10];
	posY= new float[10];
	posZ= new float[10];
	
                              
	osc = new OSC("127.0.0.1",12000);
	println(Serial.list()[0]);
	port = new Serial(this, Serial.list()[0], 115200);
}

void draw(){
	background(0);

	//if(frameCount%30==0)
	if(listen){
	getAnalogs();
	serialInput();
	}


	cub.draw(listen);




	//while (port.available() > 0) {
	
	//}
}

void stop(){
	osc.osc.stop();
	super.stop();
	
	
}




void serialInput() {
	serialString = port.readStringUntil(13);
	if (serialString != null && !serialString.equals("")) {
		//println(serialString);
		data = serialString.substring(2,serialString.length());
		vals[0] = splitTokens(data," ")[0];
		vals[1] = splitTokens(data," ")[3];
		vals[2] = splitTokens(data," ")[2];
	}
	//processByte((char)port.read());
}



void getAnalogs() {

	port.write("r a");
	port.write(13);

}

void writePos(int q){
	listen = true;
	posX[q] = cub.p.x;
	posY[q] = cub.p.y;
	posZ[q] = cub.p.z;
}

void jdi(int q){
	//if(posX[q]!=null){
	sel = q;
	listen = false;
	//}
	
}


void keyPressed(){
	if(key == 'q'){
		writePos(1);
	}else if (key=='1'){
		jdi(1);
	}
	
}


class OSC{
  OscP5 osc;
  NetAddress addr;
  int port;

  OSC(String _addr,int _port){
    port=_port;
    osc = new OscP5(this,_port-1);
    addr = new NetAddress(_addr,port);
  }

  void send(int _ident,float _whatX,float _whatY){
    OscMessage message = new OscMessage("/msg");
    String ident = (char)(_ident+65)+"";                                                          
    message.add(ident);
    //message.add("x ");
    message.add(map(_whatX,0,width,0,1));
    //message.add("y ");
    message.add(map(_whatY,0,height,1,0));
    osc.send(message, addr);                                                               
  }
  
   void send(int _ident,float _whatX,float _whatY,float _whatZ){
    OscMessage message = new OscMessage("/msg");
    String ident = (char)(_ident+65)+"";
    //message.add(ident);
    //message.add("x ");
    message.add(_whatX);
    //message.add("y ");
    message.add(_whatY);
    message.add(_whatZ);
    osc.send(message, addr);
  }
  

  void send(int _ident,float _what){
    OscMessage message = new OscMessage("/msg");
    String ident = (char)(_ident+65)+"";
    message.add(ident);
    message.add(_what);
    osc.send(message, addr);
  }

}
