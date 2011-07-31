import promidi.*;

MidiOut test;
MidiIO midiIO;

boolean rnd = false;

int num = 10;

int rate = 15;
int[] seq = {1,1,1,3,1,1,1,7};

int cntr = 0;

int dim = 255;

void setup(){
  size(300,150);
  frameRate(30);
  smooth();
  textFont(loadFont("DejaVuSans-10.vlw")); 
  textMode(SCREEN);
  
  if(rnd){
  for(int i = 0;i<seq.length;i++){
   seq[i] = (int)random(1,20); 
  }
  }

  midiIO = MidiIO.getInstance();
  //midiIO.printDevices();
  test = midiIO.getMidiOut(1,1);


}

void keyPressed(){
 if(keyCode == UP){
  rate++;
 } else if(keyCode == DOWN){
  rate--; 
 }
 
 if(rate<=1)rate=1;

  
}

void draw(){
  background(0);
  if(dim>0)dim-=20;
  
  fill(255);
  text("rate: "+rate,20,130);
  //noFill();
  //stroke;
    
  if(frameCount%rate==0){
    test.sendNote(new Note(seq[cntr],127,50));
    dim=255;
    cntr++;
    fill(255,0,0);
    if(cntr>=seq.length)cntr=0; 
  }
  
  noStroke();
  fill(#FFCC00,dim);
  rect(width-20,10,5,5);

  text((cntr+seq.length-1)%seq.length+" >> "+seq[(cntr+seq.length-1)%seq.length],20,20);
  
  for(int i = 0;i<seq.length;i++){
    if(i==(cntr+seq.length-1)%seq.length){stroke(255,0,0);fill(255,1,1,50);}else{stroke(255,155);fill(255,50);}
    rect(i*15+20,45,12,5);
    fill(255);
    text(seq[i],i*15+20,60);
  }

}

void exit(){
  midiIO.closeOutput(1);
  super.exit();
}


