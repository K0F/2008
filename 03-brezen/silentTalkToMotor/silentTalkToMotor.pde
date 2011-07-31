import processing.serial.*;
Serial s;

void setup(){
  println(Serial.list());
  s = new Serial(this,"COM14",9600); 
  s.write((int)('e'));
}

void draw(){
  if(frameCount%15 == 0){
    s.write((int)('q'));
  } 
}

void stop(){
  s.write((int)('w'));
  super.stop(); 
}

