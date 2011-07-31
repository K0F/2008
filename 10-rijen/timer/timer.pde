String [] texta;

int time;
int hours = 0;
int mins = 0;
float secs = 0;
int msc = 0;

void init(){
  frame.setUndecorated(true);
  super.init();
  
}

void setup(){
  frame.setLocation(0,0);
  size(800,600,P3D);
  textFont(loadFont("AlMohanad-72.vlw"));
  //textMode(SCREEN);
  texta = loadStrings("sub.srt");
  println(texta.length);
  frameRate(25);
}

void draw(){
  time = millis();
  //msc = time%1000;
  
  secs += (1.0/25.0);
  if(secs>=60.0){
    secs = 0;
    mins += 1;
  }
  
  if(mins>=60){
    mins=0;
    hours+=1;    
  }
    
  background(0);
  
  text(""+hours+" : "+mins+" : "+secs,100,100);
  
}

