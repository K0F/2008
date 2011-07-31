////////////////////////////////////////////////////// x //
// atrari ringtone sound is back! //////////////////////////
//  connect to a puredata oscillator patch via OSC ! ////////
// :: coDeByKoF :: ////////////////////////////////////////
//////////////////////////////////////////////////////////

import oscP5.*;
import netP5.*;

//////////////////////////////////////////////////////////

OSC osc;
PImage bck;

//////////////////////////////////////////////////////////

Drummer[] d = new Drummer[0];
 int rate = 15;
int[] cap = new int[0];

float volume = 0.028;
float tune = 20.0;
float stepTun = 1.123;

void setup(){
  size(460,280);
  //frameRate(40);
 // smooth();
  textFont(loadFont("DejaVuSans-10.vlw")); 
//  textMode(SCREEN);
  
  bck = loadImage("bck.png");
osc = new OSC("127.0.0.1",12000);
//  castDrum(new int[]{1,1,4,1,1,3});
osc.send("volume",volume);
osc.send("tune",tune);
osc.send("reset",1);
}
//////////////////////////////////////////////////////////

void draw(){
  //background(bck);
  image(bck,0,0);
  for(int i = 0;i<d.length;i++){
   if(d[i].over()){
    d[i].light = true; 
   }
    d[i].draw(); 
  }
  
  
  fill(255);
  text("rate: "+rate,20,height-10);
  String st = "";
 if(cap.length<10){
  st="00"+cap.length+"";
 }else if(cap.length>99){
   st=cap.length+"";
 }else{
   st="0"+cap.length+"";
 }
    text("       tune: "+(int)tune+"                                              #"+st+"$>");
    for(int i = 0 ;i<cap.length;i++)
    text(cap[i]+"");
    
    if(frameCount%3==0)text("_");
}

//////////////////////////////////////////////////////////

void castDrum(int[] seqenc){
  d = (Drummer[])expand(d,d.length+1);
  d[d.length-1] = new Drummer(seqenc);  
  
}


//////////////////////////////////////////////////////////

void mousePressed(){
  if(mouseButton==LEFT){
 for(int i =d.length-1;i>=0;i--){
  if(d[i].over()){
   d[i].setOffset();
   d[i].dragging=true;
   
   break; 
  }  
 }   
  }else{
    for(int i =d.length-1;i>=0;i--){
      if(d[i].over()){
       d[i].mute = !d[i].mute; 
       osc.send(d[i].id,0.0);
      }
    }
    
    
  }
}

//////////////////////////////////////////////////////////

void mouseReleased(){
  for(int i =0;i<d.length;i++){
   d[i].dragging=false; 
  }
  
  
}

//////////////////////////////////////////////////////////

void keyPressed(){
 // println(keyCode);
  if(keyCode>=48&&keyCode<=90){
  //println(keyCode-48);  
   cap = (int[])expand(cap,cap.length+1);
    cap[cap.length-1]=keyCode-48; 
  }else if(keyCode == UP){
  rate++;
 } else if(keyCode == DOWN){
  rate--; 
 }else if(keyCode == ENTER){
  if(cap.length>0){
   castDrum(cap);
  d[d.length-1].setX((int)10);
  d[d.length-1].setY((int)d.length*33-22);
  cap = new int[0];
  } 
 }else if(keyCode==DELETE){
   if(d.length>0){
  //d = (Drummer[])subset(d,0,d.length-1);
	Drummer[] tmp =d;
	d = new Drummer[tmp.length-1];
 	for(int i = 0;i<d.length-1;i++)
	d[i] = tmp[i];
	}
  osc.send(d.length,0);
 }else if(keyCode==BACKSPACE){
   if(cap.length>0)
  cap = (int[])subset(cap,0,cap.length-1); 
 }else if(keyCode==LEFT){
   tune-=stepTun;
  osc.send("tune",tune);   
 }else if(keyCode==RIGHT){
   tune+=stepTun;
   osc.send("tune",tune);
     
 }
 
 if(rate<=1)rate=1;

  
}

//////////////////////////////////////////////////////////

void stop(){
  osc.send("volume",0);
  osc.send("reset",1);
  super.stop();
}


