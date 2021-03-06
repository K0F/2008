
String addrs = 192.168.0.227;
int port 12000;

boolean running = true;

String [] data;

import oscP5.*;//import the OSC library
import netP5.*;

String fullPath;

OSC osc;

void setup(){
	size(200,100);
	osc = new OSC(addrs,port);
	stroke(255);
	
	textFont(createFont("Veranda",9));
	fullPath = sketchPath+"input/in.txt";
	data = loadStrings(fullPath);
}

void draw(){
	background(0);
	if(running){
		fill(255,255*(sin(framCount/25.0)+1));
		rect(10,10,10,10);
	}
	
	if(data[0]!=null){
		fill(255);
		text(data[0],20,10);
		data = loadStrings(fullPath);
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