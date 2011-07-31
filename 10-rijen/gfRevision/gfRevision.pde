//import processing.opengl.*;
//import promidi.*;
import traer.physics.*;

Particle mouse, b, c,d;
ParticleSystem physics;

//MidiIO midiIO;
//MidiOut midiOut;
//Controller[] h = new Controller[50];

PFont font;
int num = 15;
float[] posX = new float[num];
float[] posY = new float[num];
float[] posXm = new float[num];
float[] posYm = new float[num];
int first = 1;
float[] rah = new float[num];
void setup()
{
  size( 400, 400 ,P3D);
  frameRate( 30 );
  customizeCursor("http://weirdplace.wz.cz/imgs/cursor32.gif");
  //smooth();
  //-----------------------* frame icon
  String path = sketchPath("data/kofApp.gif"); 
  path.replace('\\','/');    
  Image img = getToolkit().getImage(path);
  frame.setIconImage(img);
  //-----------------------* frame title
  frame.setTitle("gField MIDI");
  //-----------------------*
  
  
  
  
  
  
  ellipseMode( CENTER );
  noStroke();
  
  background(0);
  physics = new ParticleSystem( 0, 0 );
  fill(255);
  rectMode(CENTER);
  mouse = physics.makeParticle();
  mouse.makeFixed();
  
  
  //midiIO = MidiIO.getInstance(this);
  //midiIO.printDevices();
  //midiOut = midiIO.getMidiOut(0,2);
  
  font = loadFont("Uni0553-8.vlw");
  textFont(font,8);
  textMode(SCREEN);
   
}

void draw()
{
  noStroke();
  fill(0,35);
  rect(width/2,height/2,width,height);
  for (int i = 1;i<num;i++){
    if (first == 1) {
      Particle d = physics.makeParticle( 1.0, i*(width/27.0),height-10, 0 );
      d.setVelocity( 0, 1, 0 );
      physics.makeAttraction( mouse, d, 100, 10);

    }

    fill(255);
    noStroke();
    Particle d = physics.getParticle(i);
    text(i,d.position().x(), d.position().y());
    //rect( d.position().x(), d.position().y(), 2, 2 );
    fill(255,150,25);
    rect( mouse.position().x(), mouse.position().y(), 3, 3 );
    if (dist(mouse.position().x(), mouse.position().y(),d.position().x(), d.position().y()) <= 180){
      stroke(255,1080/dist(mouse.position().x(), mouse.position().y(),d.position().x(), d.position().y()));
      line(mouse.position().x(), mouse.position().y(),d.position().x(), d.position().y());
    }
    handleBoundaryCollisions(d);

    noFill();
    stroke(255,8);
     
    posX[i] = d.position().x();
    posY[i] = d.position().y();
    posXm[i] = d.velocity().x();
    posYm[i] = d.velocity().y();
  }
  
  for (int q = 1;q<num;q++){
    for (int r = 1;r<num;r++){
      
      float dd = dist(posX[q],posY[q],posX[r],posY[r]);
      if(dd<180){
        //stroke(255,150,25,255/(dd/3));
        stroke(dd,255-dd,25,255/(dd/2));
      }
      else{
        stroke(255,0);
      }
      if(q!=r){
      line(posX[q],posY[q],posX[r],posY[r]);
      ellipse(posX[q],posY[q],dd*2,dd*2);
      }
     //bezier(posX[r],posY[r],posXm[r]+(dd*(sin(rah[r]+r)+1)),posYm[r]+(dd*(cos(rah[r]+r)+1)),posXm[q]-(dd*(sin(rah[q]+q)+1)),posYm[q]-(dd*(cos(rah[q]+q)+1)),posX[q],posY[q]);
     //bezier(posX[q],posY[q],posXm[r]+(dd*(sin(rah+r)+1)),posYm[r]+(dd*(sin(rah+r)+1)),posXm[r]+(dd*(sin(rah+r)+1)),posYm[r]+(dd*(sin(rah+r)+1)),posX[27-r],posY[27-r]);
     /*
     line(0,posY[q],width,posY[q]); 
    line(posX[r],0,posX[r],height); 
    */
    rah[q] +=(dd+1)/100000;
    }
    
  }
  text("gField by KOF",width-60,height-5);
  first = 0;
  physics.tick(1);
}

void handleBoundaryCollisions( Particle p )
{
  if ( p.position().x() < 0 || p.position().x() > width )
    p.setVelocity( -0.9*p.velocity().x(), p.velocity().y(), 0 );
  if ( p.position().y() < 0 || p.position().y() > height )
    p.setVelocity( p.velocity().x(), -0.9*p.velocity().y(), 0 );
  p.moveTo( constrain( p.position().x(), 0, width ), constrain( p.position().y(), 0, height ), 0 ); 
}


void mouseReleased(){
  mouse.moveTo( mouseX, mouseY, 0 );
}
void mouseDragged(){
  mouse.moveTo( mouseX, mouseY, 0 );
}

