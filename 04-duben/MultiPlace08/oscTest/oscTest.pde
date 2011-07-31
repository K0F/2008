/**
 * oscP5sendreceive by andreas schlegel
 * example shows how to send and receive osc messages.
 * oscP5 website at http://www.sojamo.de/oscP5
 */
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress localhost,remote;

String mess = "", mess2 = "";

void setup() {
  size(400,200);
  frameRate(60);
  /* start oscP5, listening for incoming messages at port 12000 */
  oscP5 = new OscP5(this,12000);
  
  /* myRemoteLocation is a NetAddress. a NetAddress takes 2 parameters,
   * an ip address and a port number. myRemoteLocation is used as parameter in
   * oscP5.send() when sending osc packets to another computer, device, 
   * application. usage see below. for testing purposes the listening port
   * and the port of the remote location address are the same, hence you will
   * send messages back to this sketch.
   */
  localhost = new NetAddress("127.0.0.1",12002);
  remote = new NetAddress("192.168.1.102",12001); //martin
  
  textFont(createFont("Arial",9));
   background(0);  
}

float x,y;
float val;


void draw() {   
  
  if(val<0.5){
  OscMessage myMessage = new OscMessage("/test");  
  myMessage.add(1.0); /* add an int to the osc message */ 
  oscP5.send(myMessage, remote);
  } else{
     OscMessage myMessage = new OscMessage("/test");  
  myMessage.add(0.0); /* add an int to the osc message */ 
  oscP5.send(myMessage, remote);    
  }
  
   background(0);  
  fill(255);
  text(mess,10,10);
  text(mess2,10,40);
  
  rect(map(x,0,1,0,width),map(y,0,1,0,height),2,2);
}



void mousePressed() {
  /* in the following different ways of creating osc messages are shown by example */
  
 
}


/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  if(theOscMessage.checkAddrPattern("X")){
  mess = theOscMessage+"\n"+
  " >> "+theOscMessage.get(0).floatValue();
  x = theOscMessage.get(0).floatValue(); 
  }else if(theOscMessage.checkAddrPattern("Y")){
  mess2 = theOscMessage+"\n"+
  " >> "+theOscMessage.get(0).floatValue();
  y = theOscMessage.get(0).floatValue(); 
  }
  
  
}
