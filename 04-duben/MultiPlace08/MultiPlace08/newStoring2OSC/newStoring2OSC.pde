import processing.video.*;
 
import oscP5.*;
import netP5.*;
  
OscP5 oscP5;

Capture in;
int W=800,H=600;

boolean viz = false;
boolean capturing = true;
boolean info = false;

PImage tmp;
int old[];
int numPixels = W*H;
PImage[] cyklon = new PImage[0];
float movementSum,movement;
int iNo = 0;

float treshold = 0.7;
int timer = 50;
int time;

int rewrite = 0;

int filename = 0;

void setup(){
  size(W,H,P3D);
  in = new Capture(this, W, H);

  noStroke();
  old = new int[numPixels];
  
  oscP5 = new OscP5(this,2222);
  
  textFont(createFont("Arial",9));
  textMode(SCREEN);
  // osc = new OSC("127.0.0.1",12000);

  tmp = createImage(1,1,RGB);

  loadPixels();
  frame.setTitle("mtpsSkolska28");
  frame.setLocation(screen.width,0);
}

void init(){
  frame.setUndecorated(true);
  super.init(); 

}


void draw(){
  if (in.available()) {
    in.read();
    in.loadPixels();

    movement = 0;
    
     for(int x = 0;x<W;x+=10){
      for(int y = 0;y<H;y+=10){

        int num = y*W+x;

        color currColor = in.pixels[num];
        color prevColor = old[num];

        int currR = (currColor >> 16) & 0xFF;
        int currG = (currColor >> 8) & 0xFF;
        int currB = currColor & 0xFF;

        int prevR = (prevColor >> 16) & 0xFF;
        int prevG = (prevColor >> 8) & 0xFF;
        int prevB = prevColor & 0xFF;

        int diffR = abs(currR - prevR);
        int diffG = abs(currG - prevG);
        int diffB = abs(currB - prevB);

        movement += (diffR + diffG + diffB)/(W*H/5.0+1.0);

        old[num] = currColor;

        if(viz){
          pixels[num] = (currR << 16) | (currG << 8) | currB;
          updatePixels();
        }
     }
    }
   
   if(time>0){
   time--;
   }
  
 /*
  if(movement>treshold&&time==0){
    capture();
    time=timer;
  }*/
}
  if(cyklon.length>0){
    display(125);
                  }
  
  
  if(info){
    fill(#FFCC00);
    text("fr. "+cyklon.length+"\ntimer "+time+"\ntresh "+treshold,10,10);
  }
}

void oscEvent(OscMessage theOscMessage) {
 
  if(theOscMessage.checkAddrPattern("/start")){
  float x = theOscMessage.get(0).intValue(); 
   if (x==1){
     //println(theOscMessage);
   capture();
   }  

}
  
  
}


void keyPressed(){
 if(keyCode==DELETE){
  cyklon = new PImage[0];iNo = 0;
 }else if(keyCode==UP){
  treshold += 0.1; 
 }else if(keyCode==DOWN){
  treshold -= 0.1;
 } else if(key == ' '){
   capture();
   
 }
 treshold = constrain(treshold,0.1,10.0);
  
}

void display(int alph){

  tint(255,alph);
  image(cyklon[iNo],0,0);
  iNo++;
  iNo=iNo%cyklon.length; 
}


void capture(){
   
  tmp = createImage(W,H,RGB);
  for(int x=0;x<W;x++){
    for(int y=0;y<H;y++){
      tmp.pixels[y*W+x] = in.pixels[y*W+x];
    }
  }
  if(cyklon.length<135){

    cyklon = (PImage[])expand(cyklon,cyklon.length+1);
    cyklon[cyklon.length-1] = tmp;//createImage(tmp.width,tmp.height,RGB);
    println(cyklon.length);
    tmp.save("out/captOstro2"+filename+".png");
    //
    filename++;
  }else{
   cyklon[rewrite] = tmp; 
    rewrite++;
    rewrite=rewrite%cyklon.length;
  }
}
