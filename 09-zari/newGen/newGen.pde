int gi = 0;
Botr[] b;
int poc = 1000;
int cntr = 0;

boolean record = true;
String fnme = "catch2";

void setup(){
  size(screen.width/3,screen.height/3,P3D);
  //mm = new MovieMaker(this, width, height, "drawing.mov",25, MovieMaker.JPEG, MovieMaker.HIGH);
  background(0);
  textFont(loadFont("AlMohanad-10.vlw"));
  textMode(SCREEN);
 reset(poc);
}

void draw(){
  //background(0);
  fill(0,5);
  noStroke();
  rect(0,0,width,height);
  
  for(int i = 0;i<b.length;i++){
  b[i].run();
}

  if(record&&frameCount>10){
 
    fill(#ff1111);
    text("write",10,10);
  }
  
  if(frameCount%50==0){
    save("vid/screen"+nf(cntr,4)+".png");
    cntr++;
    reset(poc);    
  }
 
  }
  
 // mm.addFrame(pixels,width,height);



void stop(){
  if(record){
  makeVid("vid",fnme);
  }
  super.stop();
}

void keyPressed(){
  if(key=='q'){
    exit();
  }else if(key=='r'){
    record=!record;
  }
}

void reset(int kolik){
   b = new Botr[kolik];
   gi=0;
  for(int i =0;i<b.length;i++){
    
    b[i] = new Botr();  
  }
    
    
  //  float qq =100;//1.00512 * poc;
    //poc = (int)qq;
    background(0);
}



