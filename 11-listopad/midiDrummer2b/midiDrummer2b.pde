import promidi.*;

MidiOut test;
MidiIO midiIO;

Drummer[] d = new Drummer[0];
 int rate = 15;
int[] cap = new int[0];

void setup(){
  size(360,280);
  frameRate(30);
  smooth();
  textFont(loadFont("DejaVuSans-10.vlw")); 
  textMode(SCREEN);
  

  midiIO = MidiIO.getInstance();
  //midiIO.printDevices();
  test = midiIO.getMidiOut(1,1);
//  castDrum(new int[]{1,1,4,1,1,3});

}

void keyPressed(){
  
  if(keyCode>=49&&keyCode<=57){
  //println(keyCode-48);  
   cap = (int[])expand(cap,cap.length+1);
    cap[cap.length-1]=keyCode-48; 
  }else if(keyCode == UP){
  rate++;
 } else if(keyCode == DOWN){
  rate--; 
 }else if(keyCode == ENTER){
  castDrum(cap);
  d[d.length-1].setX((int)mouseX);
  d[d.length-1].setY((int)mouseY);
  cap = new int[0]; 
 }
 
 if(rate<=1)rate=1;

  
}

void draw(){
  background(111);
  
  for(int i = 0;i<d.length;i++){
   if(d[i].over()){
    d[i].light = true; 
   }
    d[i].draw(); 
  }
  
  
  fill(255);
  text("rate: "+rate,20,height-10);
    
}

void castDrum(int[] seqenc){
  d = (Drummer[])expand(d,d.length+1);
  d[d.length-1] = new Drummer(seqenc);  
  
}



void exit(){
  midiIO.closeOutput(1);
  super.exit();
}


