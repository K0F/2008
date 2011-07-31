//import processing.opengl.*;
Recorder r;
PImage frame,tmp;
PGraphics p;

int num = 200;

float x[] = new float[num];
float y[] = new float[num];
float sp[] = new float[num];
float ve[] = new float[num];

int cyc=1,cyc2=1;

void setup(){
  size(1280,720,P3D); 
  frameRate(30);
  r = new Recorder("flick","hiResMadness.avi");
  frame = loadImage("frame.png");
  p = createGraphics(width,height,P3D);
  //  p.colorMode(ARGB);
  noStroke();

  for(int i =0;i<num;i++){
    x[i] = random(10,width-10);
    y[i] = random(10,height-10); 
    sp[i] = random(2,200.0);
    ve[i] = random(5,80);

  }

  //smooth();
}

void draw(){
  if(frameCount%2==0){
    fill(0);
  } 
  else{
    fill(255);

  }

  rect(0,0,width,height);

  //image(p,0,0);
for(int i =0;i<num;i++){
    float q =255-brightness(get((int)x[i],(int)y[i]));
    fill(q);
    //stroke(q,155);
    //vertex(x[i],y[i]);
    noStroke();
    ell(x[i],y[i],sp[i],ve[i]);
  } 
  //endShape();

  //beginShape() ;
  
  tint(0);
  image(frame,random(-6,0),random(-6,0),width+6,height+6);  
  filter(BLUR,3);

  

  r.add();

}

void ell(float x,float y,float speed,float velikost){


  // fill(255);
  ellipse(x,y,velikost*(sin(frameCount/speed)+1),velikost*(sin(frameCount/speed)+1));
  //filter(INVERT);
}


void keyPressed(){
  if(key=='q'){
    r.finish();
    exit();
  } 

}





