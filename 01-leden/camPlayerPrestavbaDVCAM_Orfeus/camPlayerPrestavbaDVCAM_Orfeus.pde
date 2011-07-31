////////////////////////////////////////////////////////////////////////////////// Main

import processing.opengl.*;
import oscP5.*;
import netP5.*;
//////////////////////////////////////////////////////////////////////////////////

PFont font;
Player player;
CPanel cp;

//////////////////////////////////////////////////////////////////////////////////

void setup(){
  size(450,360,OPENGL); //
  background(0);
  
  player = new Player(this,25,1,12,2,2); //tolerance, interval,nastroj,modNastroje,MidioutKanal
  cp = new CPanel(170,0);
 
    
  frameRate(25); //!!!!

  //-----------------------* frame icon
  String path = sketchPath("data/ico.gif"); 
  path.replace('\\','/');    
  Image img = getToolkit().getImage(path);
  frame.setIconImage(img);
  //-----------------------* frame title
  frame.setTitle("camPlr 1.14 mod :: krystof pesek");
  //-----------------------*
  frame.show(); 
  
  //rectMode(CENTER);

  font = loadFont("Uni0553-8.vlw");
  textFont(font, 8);
  println("/////////////////////////////////////");
  println("this world is weird so let's dance!");
  println("/////////////////////////////////////");

}

//////////////////////////////////////////////////////////////////////////////////

void draw(){
  background(0);
  player.draw();  
  cp.run(); 
}

//////////////////////////////////////////////////////////////////////////////////

void oscEvent(OscMessage theOscMessage) {
  /* print the address pattern and the typetag of the received OscMessage */
  print("### received an osc message.");
  print(" addrpattern: "+theOscMessage.addrPattern());
  println(" typetag: "+theOscMessage.typetag());
}
