//import processing.opengl.*;
import traer.physics.*;

Point[] ps;

Writer writer;
ParticleSystem physics;
SnuraPhy[] snura;
GeomParser cr;
float gravity = 1;

//drawing
float rotX,zoom;
float SX[],SY[],SZ[];
boolean flipped = false;

// interface
boolean selecting = true;
int which = 0;
int sel1,sel2;
boolean got = false;
boolean dragging = false;
float CPOINT[] = new float[3];

// -----------------------------------------------------  >

/*
void init(){
  frame.setUndecorated(true);
  super.init();
}
*/

void setup(){
  frame.setTitle(":: gaudi physique by kof ::");
   frame.setLocation(0,0);
  size(1024,800,P3D);//OPENGL); 
 
  cursor(CROSS); 
  frameRate(30);
  
  loadIcon("icon16.png");

  reload();

  ////////////////////////////////////////////////////////////
  addMouseWheelListener(new java.awt.event.MouseWheelListener() {
    public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) {
      int notches = evt.getWheelRotation();
      if(notches!=0){
        gravity+=notches;//*0.05;
        physics.setGravity( gravity );}}});     
  ////////////////////////////////////////////////////////////

  background(0);
  textFont(loadFont("AlManzomah-12.vlw"));
  textMode(SCREEN);
  fill(255,55);
  stroke(255);

  
}

void draw(){  
  select();
  // -----------------------------------------------------  >
  physics.advanceTime( 1.0 );
  background(0);
  transform();
}






