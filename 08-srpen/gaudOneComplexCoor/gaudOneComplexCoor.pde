//import processing.opengl.*;
import traer.physics.*;
import proxml.*;


//system
CoorParser cr;
Point[] ps;
Writer writer;
ParticleSystem physics;
SnuraPhy[] snura;
float gravity = 5;

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

/*
void init(){
 frame.setUndecorated(true);
 super.init();
 }*/

void setup(){
  frame.setTitle(":: gaudi physique ::");
  size(800,500,P3D);//OPENGL);
  //frame.setLocation(0,0);
  cursor(CROSS); 
  frameRate(30);

  cr = new CoorParser("klenba.geom");
  ps = new Point[cr.pocetP()];
  SX=new float[ps.length];
  SY=new float[ps.length];
  SZ=new float[ps.length];


  for(int i = 0; i<ps.length;i++){    
    ps[i] = new Point( cr.getCoordinates(i)[0],
    cr.getCoordinates(i)[1],
    cr.getCoordinates(i)[2], i );
  }    
  println("coords loaded");

  // ------------------------------- >
  //pocet,body A B,hmota,sila,pruznost,vule

  physics = new ParticleSystem( gravity, 0.85 );
  reint(11);
  //initialize physics

  ////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////
  //--( liminal )-- MouseWheel
  //PLEASE see: http://processing.org/discourse/yabb/YaBB.cgi?board=Syntax;action=display;num=1110627607;start=3
  ////////////////////////////////////////////////////////////
  ////////////////////////////////////////////////////////////
  addMouseWheelListener(new java.awt.event.MouseWheelListener() {
    public void mouseWheelMoved(java.awt.event.MouseWheelEvent evt) {
      int notches = evt.getWheelRotation();
      if(notches!=0){
        gravity+=notches*0.5;
        physics.setGravity( gravity );
        //println(notches);
        //println(notches);//pmz+=notches*10;
        //drawZoomControl();
      }
    }
  }
  );
  ////////////////////////////////////////////////////////////  
  ////////////////////////////////////////////////////////////

  background(0);
  textFont(loadFont("AlManzomah-12.vlw"));
  //textMode(SCREEN);
  fill(255,55);
  stroke(255);

  writer = new Writer();
}

void draw(){  

  if(keyPressed&&key==' '){
    selecting = true;
  }
  else{
    selecting = false;
  }
  stroke(255);


  if(selecting){

    got = false;
    for(int i = 0;i<snura.length;i++){
      snura[i].colSel = color(255);

      if(snura[i].over()&&!got){
        snura[i].colSel = color(255,0,0);
        got = true;
        which = i;
      }
    }
  }

  physics.advanceTime( 1.0 );
  background(0);
  transform();

}

void transform(){
  if(!selecting){
    rotX+=0.2*(mouseX-rotX);
    zoom += 0.08*(mouseY-zoom);
  }
  else{
    rotX+=0.0002*(mouseX-rotX);
    zoom += 0.00008*(mouseY-zoom);
  }

  pushMatrix();
  rotateX(radians(-400));

  pushMatrix();
  translate(width/2,height/2);
  scale(map(zoom,0,height,10,0.2));
  if(flipped){
    scale(-1,-1,-1);
  }
  rotateY(radians(rotX));  
  pushMatrix();

  //rotateX(radians(-270));

  for(int i = 0; i<ps.length;i++){
    int next = constrain(i-1,0,ps.length);
    //line(ps[i].x,ps[i].y,ps[i].z,ps[next].x,ps[next].y,ps[next].z);
    SX[i] = screenX(ps[i].x,ps[i].y,ps[i].z);
    SY[i] = screenY(ps[i].x,ps[i].y,ps[i].z);
    SZ[i] = screenZ(ps[i].x,ps[i].y,ps[i].z);

    ps[i].draw(255);//(int)map(SZ[i],0.94,0.92,120,250));
  }  

  for(int i = 0; i<snura.length;i++){
    snura[i].draw();  
  }  

  if(dragging){
    line(
    snura[which].particles[snura[sel2].returnLowest()].position().x(),
    snura[which].particles[snura[sel2].returnLowest()].position().y(),
    snura[which].particles[snura[sel2].returnLowest()].position().z(),
    snura[which].particles[snura[sel2].returnLowest()].position().x(),
    snura[which].particles[snura[sel2].returnLowest()].position().y(),
    snura[which].particles[snura[sel2].returnLowest()].position().z());
  }
  popMatrix();

  popMatrix();   

  popMatrix();

  fill(255,128,0,150);
  for(int i =0;i<SX.length;i++){

    text("<-----   "+i,SX[i]+20,SY[i]+5);
    noFill();
    stroke(255,128,0,150);
    ellipse(SX[i],SY[i],45,45);  
  }
}

void mousePressed(){
  if(selecting&&got){
    sel1=  which;
    dragging = true;
  }
  else if(mouseButton==RIGHT){
    writer.writeToFile("klenba.cloud");
  }  
}

void mouseReleased(){
  if(selecting&&got){
    sel2 = which;
    addLev(sel1,sel2);
    dragging = false;
  }  
}

void keyPressed(){
  if(keyCode==UP){
    gravity-=0.2;
    physics.setGravity( gravity );
  }
  else if(keyCode==DOWN){
    gravity+=0.2;
    physics.setGravity( gravity );
  }
}


