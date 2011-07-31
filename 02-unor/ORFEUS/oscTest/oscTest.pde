/**
 * oscP5multicast by andreas schlegel
 * example shows how to send osc via a multicast socket.
 * what is a multicast? http://en.wikipedia.org/wiki/Multicast
 * ip multicast ranges and uses:
 * 224.0.0.0 - 224.0.0.255 Reserved for special “well-known” multicast addresses.
 * 224.0.1.0 - 238.255.255.255 Globally-scoped (Internet-wide) multicast addresses.
 * 239.0.0.0 - 239.255.255.255 Administratively-scoped (local) multicast addresses.
 * oscP5 website at http://www.sojamo.de/oscP5
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;

void setup() {
  size(400,400);
  frameRate(30);
  rectMode(CENTER);
  noFill();
  stroke(255,55);
  cursor(CROSS);
  /* create a new instance of oscP5 using a multicast socket. */
  oscP5 = new OscP5(this,"127.0.0.1",12000);
}

float x,y,x1,y1;
float speed = 15.0;
float vel;

void draw() {
  x1=x;
  y1=y;
  
  x+=(mouseX-x)/speed;
  y+=(mouseY-y)/speed;
  
  vel = abs(x-x1)+abs(y-y1); 

  background(0);

  rect(x,y,10,10);

  OscMessage myOscMessage = new OscMessage("/test");
  myOscMessage.add((int)x);
  myOscMessage.add(" * ");
  myOscMessage.add((int)y);
  myOscMessage.add(" * ");
  myOscMessage.add(((int)(vel*1000.0))/100.0);
  oscP5.send(myOscMessage);

}

