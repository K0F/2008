import processing.opengl.*;

Surfrace sur;
int cnt;


void init(){
  frame.setUndecorated(true);
  super.init(); 

}

void setup(){
  size(screen.width,screen.height,OPENGL);
  frame.setLocation(0,0);
  sur = new Surfrace();
  background(255);  
  //smooth();
  //strokeWeight(2);
}

void draw(){
  background(0);
  pushMatrix();
  translate(width/2-sur.center[0],height/2-sur.center[1],sur.center[2]);
  pushMatrix();
  rotateY(radians(cnt/2));
  sur.draw(); 

  popMatrix();
  popMatrix();
  
  cnt++;
  if(frameCount%2==0)sur.grow();

}

void mousePressed(){
  sur.grow(); 

}

void keyPressed(){
 if(key == ' '){
  save("screen.png");
 } 
}

