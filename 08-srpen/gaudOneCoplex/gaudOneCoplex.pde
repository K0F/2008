XMLParser par;
Point[] ps;
 ParticleSystem physics;
SnuraPhy[] sura;
float rotX,zoom;
float SX[],SY[],SZ[];
boolean flipped = false;

/*
void init(){
 frame.setUndecorated(true);
 super.init();
 }*/



void setup(){
  frame.setTitle(":: gaudi physique ::");
  size(800,500,P3D);
  //frame.setLocation(0,0);
  cursor(CROSS); 
  frameRate(30);
  physics = new ParticleSystem( 5.0, 0.05 );

  par = new XMLParser(this,"datos2.xml");
  ps = new Point[par.pocet()];
  SX=new float[ps.length];
  SY=new float[ps.length];
  SZ=new float[ps.length];

  for(int i = 0; i<ps.length;i++){
    ps[i] = new Point( par.getPointDimensions(i)[0],
    par.getPointDimensions(i)[1],
    par.getPointDimensions(i)[2], i );
  }

  // ------------------------------- >
  //pocet,body A B,hmota,sila,pruznost,vule


  reint(15);
  //initialize physics

  background(0);
  textFont(loadFont("AlManzomah-12.vlw"));
  textMode(SCREEN);
  fill(255,55);
  stroke(255);
}

void draw(){  
  physics.advanceTime( 1.0 );
  background(0);
  transform();
}

void transform(){
  rotX+=0.2*(mouseX-rotX);
  zoom += 0.08*(mouseY-zoom);

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

  for(int i = 0; i<sura.length;i++){
    sura[i].draw();  
  }  
  popMatrix();

  popMatrix();   

  popMatrix();

  fill(255,128,0,150);
  for(int i =0;i<SX.length;i++){

    text("<-----   "+i,SX[i]+20,SY[i]+5);
    noFill();
    ellipse(SX[i],SY[i],45,45);  
  }



}

void mousePressed(){
  if(mouseButton==LEFT){
    for(int i = 0;i<sura.length;i++){
      sura[i].reset();
    }
  }
  else{
    flipped=!flipped;
  }  
}

void keyPressed(){
  println((int)key-48);
  addLev((int)key-48,(int)key-48+1);  
}

void addLev(int A,int B){
   int parA = sura[A].returnLowest();
    int parB = sura[B].returnLowest();
    int parents[] = {A,B};
    
    println(A+" lowestPoint @ "+parA);
    println(B+" lowestPoint @ "+parB);
    //println("2");
    
    ps = (Point[])expand(ps,ps.length+2);
    
    //println("3");
    
    ps[ps.length-1] = new Point(sura[A].particles[parA].position().x(),
    sura[A].particles[parA].position().y(),
    sura[A].particles[parA].position().z(),ps.length-2);
    
    
    ps[ps.length-2] = new Point(sura[B].particles[parB].position().x(),
    sura[B].particles[parB].position().y(),
    sura[B].particles[parB].position().z(),ps.length-1);
    //println("4");
    
    SX = (float [])expand(SX,SX.length+2);
    SY = (float [])expand(SY,SY.length+2);
    SZ = (float [])expand(SZ,SZ.length+2);
    
    sura = (SnuraPhy[])expand(sura,sura.length+1);
    sura[sura.length-1] = new SnuraPhy(sura[0].particles.length , ps[ps.length-1],ps[ps.length-2] ,10.0,10.0,9.0,0.0001,parents);
}

void reint(int kolik){  
  sura = new SnuraPhy[ps.length];
  for(int i =0;i<sura.length;i++){
    sura[i] = new SnuraPhy(kolik , ps[i],ps[(i+1)%(ps.length-1)] ,10.0,10.0,9.0,0.0001);
  }  
}
