import oscP5.*;
import netP5.*;


OSC osc;
float x,y;
float theta,dista;
PImage img;

void setup(){
	size(400,400);
	textFont(createFont("Arial",9));
	background(0);
	
	osc = new OSC("127.0.0.1",12000);
	
	img=loadImage("img.png");
	
	cursor(CROSS);
	//smooth();
	
}

void draw(){
	background(0);
	
	compute();
	stroke(255,150);
	point(x,y);
	line(x,y,mouseX,mouseY);
	theta = atan2(y-mouseY,x-mouseX);
	dista = dist(x,y,mouseX,mouseY);
	pushMatrix();
	translate(mouseX,mouseY);
	rotate(theta);
	//tint(255,35);
	image(img,0,-dista/2,dista,dista);
	popMatrix();
	
	fill(255);
	text(mouseX + " :: "+mouseY,10,10);
	text(x + " :: "+y,10,20);
	
	osc.send(0,mouseX,mouseY);
	osc.send(1,x,y);
	
}

void compute(){
	x+=(mouseX-x)/100.0f;
	y+=(mouseY-y)/100.0f;
	
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
		message.add(map(_whatY,0,height,0,1));
		osc.send(message, addr);
	}

void send(String _ident,float _what){
		OscMessage message = new OscMessage("/msg");
		message.add(_ident);
                message.add(_what);
		osc.send(message, addr);
	}

}
