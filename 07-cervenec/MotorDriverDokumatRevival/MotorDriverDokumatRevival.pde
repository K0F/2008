import processing.serial.*;
Serial s;

void setup(){
  size(320,240);
  println(Serial.list());
  frameRate(30);
  s = new Serial(this,"COM2",9600); 
  s.write((int)('e'));
  s.write((int)100);
}

void draw(){
  background(0);
}

void cyklon(){
 
  if(frameCount%60 == 0){
    s.write((int)('q'));
  }  
}

void stop(){
  s.write((int)('w'));
  super.stop(); 
}


void keyPressed(){
 if(key=='q'){
  s.write((int)('q'));
 } else if(key=='w'){
   s.write((int)('w'));
 }else if(key=='e'){
   s.write((int)('e'));
 }
 
 keyPressed=false;
  
}

