import processing.opengl.*;

PImage[] img;
PFont font;
float pull;
float Xrot;

boolean coloring = false;
color c[];
color a = #aaaaff;
color b = #ffff33;
float fade = 0;


float speed = 30.0;

void init(){
 frame.setUndecorated(true);
  super.init(); 
  
}

void setup(){
  size(screen.width,screen.height,OPENGL);

  img = new PImage[6];
  c = new color[img.length];
  
  for(int i =0;i<img.length;i++){
    img[i] = loadImage("p"+(i+1)+".png");
    c[i] = lerpColor(a,b,norm(i,0,img.length-1));
  } 
  
  font = loadFont("Arial-BoldMT-12.vlw");
  textFont(font);
  
  
  //smooth();
}
int cnt =0;
void draw(){
  background(0);
  pull += ((height-mouseY)-pull)/speed;
  Xrot += ((radians(width/2.0-mouseX))-Xrot)/speed;
  
  if(coloring){
   fade+=0.1; 
  }else{
   fade-=0.1; 
  }
  
  fade = constrain(fade,0,1);
  
  drawThatAll();
  
  fill(255,150);
  text("pudorysy #2 :: kof",width-120,height-12);
  
  
}

void drawThatAll(){
 pushMatrix();
  translate(width/2,height/2,-200);
  pushMatrix();
  rotateX(radians(60));
  pushMatrix();
  rotateZ(Xrot);
  
  for(int i =0;i<img.length;i++){
    pushMatrix();
    translate(0,0,i*(pull)/3.0);
    
   tint(lerpColor(color(255),c[i],fade),180);
    
    image(img[i],-img[i].width/2,-img[i].height/2);
    popMatrix();
  }
  
  popMatrix();
  popMatrix();
 translate(-width/2,-height/2,0);
  popMatrix(); 
  
}

void mousePressed(){
 if(coloring){
  coloring = false;
 } else{
  coloring=true; 
 }
 mousePressed = false;
}
