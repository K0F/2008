import processing.candy.*;
import processing.xml.*;

Node node;

void setup(){
  size(500,300);
  background(0); 
  node = new Node(this,1);
}


void draw(){
  background(0);
  node.draw();

}





class Node{
  SVG bot;  
  float x,y,k;
  int id;
  PApplet p;

  Node(PApplet _p,int _id){
    id=_id;
    p=_p;
    bot = new SVG(p, "botOne.svg"); 
    k=3.0;
  }

  void draw(){
    k = 3*(sin(frameCount/10.0)+1.0);
    bot.draw(mouseX-bot.width/(2*k), mouseY-bot.height/(2*k),bot.width/k,bot.height/k);   

  }



}
